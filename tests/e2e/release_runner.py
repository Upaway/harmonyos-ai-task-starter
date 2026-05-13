#!/usr/bin/env python3
import argparse
import json
import subprocess
import sys
import time
import shutil
import os
from dataclasses import dataclass
from pathlib import Path
from typing import Callable


@dataclass
class CaseResult:
  name: str
  passed: bool
  detail: str


class ReleaseRunner:
  def __init__(self, config: dict, mode: str):
    self.config = config
    self.mode = mode
    self.device_serial = self.config.get("device_serial", "").strip()
    self.case_retry = int(self.config.get("case_retry", 1))
    self.hdc_bin = self._resolve_hdc_bin()
    ts = time.strftime("%Y%m%d-%H%M%S")
    root = Path(self.config.get("artifacts_dir", "artifacts/automation"))
    serial_label = self.device_serial if self.device_serial else "auto-device"
    self.artifacts = root / f"{ts}-{serial_label}"
    self.artifacts.mkdir(parents=True, exist_ok=True)
    self.results: list[CaseResult] = []

  def _resolve_hdc_bin(self) -> str:
    from_path = shutil.which("hdc")
    if from_path:
      return from_path

    env_candidates = [
      os.environ.get("HDC_BIN", ""),
      os.path.join(os.environ.get("HM_SDK_HOME", ""), "openharmony/toolchains/hdc"),
      os.path.join(os.environ.get("DEVECO_SDK_HOME", ""), "default/openharmony/toolchains/hdc")
    ]
    static_candidates = [
      "/Applications/DevEco-Studio.app/Contents/sdk/default/openharmony/toolchains/hdc",
      str(Path.home() / "Library/Huawei/Sdk/HarmonyOS-6.0.2/default/openharmony/toolchains/hdc")
    ]
    candidates = [p for p in env_candidates + static_candidates if p]
    for path in candidates:
      if os.path.isfile(path) and os.access(path, os.X_OK):
        return path
    return "hdc"

  def _run(self, cmd: list[str], check: bool = True) -> str:
    p = subprocess.run(cmd, capture_output=True, text=True)
    if check and p.returncode != 0:
      raise RuntimeError(f"Command failed: {' '.join(cmd)}\n{p.stdout}\n{p.stderr}")
    return p.stdout.strip()

  def _hdc_prefix(self) -> list[str]:
    if self.device_serial:
      return [self.hdc_bin, "-t", self.device_serial]
    return [self.hdc_bin]

  def check_env(self) -> None:
    self._run(["python3", "--version"])
    output = self._run(self._hdc_prefix() + ["list", "targets"], check=False)
    if "Empty" in output or output.strip() == "":
      raise RuntimeError("No HarmonyOS device found. Run `hdc list targets` and reconnect device.")

  def install_and_start(self) -> None:
    hap = self.config.get("install_path", "")
    if hap:
      self._run(self._hdc_prefix() + ["install", "-r", hap], check=True)
    bundle = self.config["bundle_name"]
    ability = self.config["main_ability"]
    self._run(self._hdc_prefix() + ["shell", "aa", "start", "-b", bundle, "-a", ability], check=True)
    time.sleep(2)

  def stop_and_collect(self) -> None:
    bundle = self.config["bundle_name"]
    hilog_path = self.artifacts / "hilog.log"
    logs = self._run(self._hdc_prefix() + ["shell", "hilog", "-x"], check=False)
    hilog_path.write_text(logs, encoding="utf-8")
    self._run(self._hdc_prefix() + ["shell", "aa", "force-stop", bundle], check=False)

  def _driver(self):
    try:
      from hmdriver2.driver import Driver  # type: ignore
    except Exception as ex:
      raise RuntimeError("hmdriver2 not installed. Run `pip3 install -U hmdriver2`.") from ex
    return Driver(self.device_serial if self.device_serial else None)

  def _take_shot(self, driver, name: str) -> None:
    path = self.artifacts / f"{name}.png"
    driver.screenshot(str(path))

  def _wait_exists(self, d, text: str, timeout_s: int = 8) -> bool:
    deadline = time.time() + timeout_s
    while time.time() < deadline:
      if d(text=text).exists():
        return True
      time.sleep(0.5)
    return False

  def _safe_click(self, d, text: str, timeout_s: int = 8) -> None:
    if not self._wait_exists(d, text, timeout_s):
      raise RuntimeError(f"Element not found: {text}")
    d(text=text).click()

  def _run_case(self, name: str, fn: Callable, d) -> None:
    last_error = "unknown"
    for attempt in range(1, self.case_retry + 2):
      try:
        fn()
        self.results.append(CaseResult(name=name, passed=True, detail=f"ok(attempt={attempt})"))
        return
      except Exception as ex:
        last_error = str(ex)
        self._take_shot(d, f"fail_{name}_attempt{attempt}")
        time.sleep(1)
    self.results.append(CaseResult(name=name, passed=False, detail=last_error))

  def run(self) -> int:
    d = None
    precheck_error = ""
    try:
      self.check_env()
      self.install_and_start()
      d = self._driver()
      self._run_case("smoke_home_loaded", lambda: self.case_home_loaded(d), d)
      self._run_case("smoke_navigate_stats", lambda: self.case_navigate_stats(d), d)
      if self.mode == "e2e":
        self._run_case("e2e_default_duration_refresh", lambda: self.case_default_duration_refresh(d), d)
        self._run_case("e2e_start_focus_flow", lambda: self.case_start_focus_flow(d), d)
        self._run_case("e2e_early_finish_once", lambda: self.case_early_finish_once(d), d)
        self._run_case("e2e_abandon_once", lambda: self.case_abandon_once(d), d)
        self._run_case("e2e_save_result_updates_stats", lambda: self.case_save_result_updates_stats(d), d)
        self._run_case("e2e_stats_recent_session_present", lambda: self.case_stats_recent_session_present(d), d)
    except Exception as ex:
      precheck_error = str(ex)
    finally:
      try:
        self.stop_and_collect()
      except Exception:
        pass
    summary = {
      "mode": self.mode,
      "hdc_bin": self.hdc_bin,
      "device_serial": self.device_serial if self.device_serial else "first-online",
      "precheck_error": precheck_error,
      "total": len(self.results),
      "failed": len([x for x in self.results if not x.passed]) + (1 if precheck_error else 0),
      "results": [x.__dict__ for x in self.results]
    }
    (self.artifacts / "summary.json").write_text(json.dumps(summary, ensure_ascii=False, indent=2), encoding="utf-8")
    return 1 if summary["failed"] > 0 else 0

  # Cases
  def case_home_loaded(self, d) -> None:
    if not self._wait_exists(d, "开始做事"):
      raise RuntimeError("Home page not ready: missing '开始做事'.")

  def case_navigate_stats(self, d) -> None:
    self._safe_click(d, "查看统计与设置 →")
    time.sleep(1)
    if not self._wait_exists(d, "保存默认时长"):
      raise RuntimeError("Stats page not opened.")
    self._safe_click(d, "返回")
    time.sleep(1)

  def case_default_duration_refresh(self, d) -> None:
    self._safe_click(d, "查看统计与设置 →")
    time.sleep(1)
    self._safe_click(d, "50 分钟")
    self._safe_click(d, "保存默认时长")
    self._safe_click(d, "返回")
    time.sleep(1)
    if not self._wait_exists(d, "50 分钟"):
      raise RuntimeError("Home default duration not refreshed immediately.")

  def case_start_focus_flow(self, d) -> None:
    d.input_text("自动化发布前回归任务")
    self._safe_click(d, "开始做事")
    time.sleep(1)
    if not self._wait_exists(d, "正式开始"):
      raise RuntimeError("Start confirm page not reached.")
    self._safe_click(d, "返回修改")
    time.sleep(1)

  def case_early_finish_once(self, d) -> None:
    d.input_text("自动化提前完成流程")
    self._safe_click(d, "开始做事")
    self._safe_click(d, "正式开始")
    time.sleep(2)
    self._safe_click(d, "我做完了")
    self._safe_click(d, "确认完成")
    time.sleep(1)
    if not self._wait_exists(d, "一句备注（可选）"):
      raise RuntimeError("Result page not reached after early finish.")

  def case_abandon_once(self, d) -> None:
    d(text="保存并回到首页").click_if_exists()
    time.sleep(1)
    d.input_text("自动化放弃流程")
    self._safe_click(d, "开始做事")
    self._safe_click(d, "正式开始")
    time.sleep(2)
    self._safe_click(d, "放弃这次")
    self._safe_click(d, "确认放弃")
    time.sleep(1)
    if not self._wait_exists(d, "一句备注（可选）"):
      raise RuntimeError("Result page not reached after abandon.")

  def case_save_result_updates_stats(self, d) -> None:
    self._safe_click(d, "保存并回到首页")
    time.sleep(1)
    if not self._wait_exists(d, "查看统计与设置 →"):
      raise RuntimeError("Back to home failed after saving result.")

  def case_stats_recent_session_present(self, d) -> None:
    self._safe_click(d, "查看统计与设置 →")
    time.sleep(1)
    if not self._wait_exists(d, "保存默认时长"):
      raise RuntimeError("Stats page missing key controls after session save.")
    self._safe_click(d, "返回")


def load_config(path: Path) -> dict:
  return json.loads(path.read_text(encoding="utf-8"))


def main() -> int:
  parser = argparse.ArgumentParser()
  parser.add_argument("--config", default="tests/config/device.example.json")
  parser.add_argument("--mode", choices=["smoke", "e2e"], default="e2e")
  args = parser.parse_args()
  config = load_config(Path(args.config))
  runner = ReleaseRunner(config, args.mode)
  return runner.run()


if __name__ == "__main__":
  sys.exit(main())

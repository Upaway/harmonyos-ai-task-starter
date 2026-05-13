# 自动化测试目录说明

## 目录结构

- `tests/config/device.example.json`：设备与包配置模板。
- `tests/smoke/run_smoke.py`：发版阻断级冒烟入口。
- `tests/e2e/release_runner.py`：主流程 E2E 执行器（含截图与汇总报告）。

## 运行方式

1. 先按实际设备修改配置文件：

```json
{
  "bundle_name": "你的包名",
  "main_ability": "EntryAbility",
  "device_serial": "可选，留空使用第一个在线设备",
  "artifacts_dir": "artifacts/automation",
  "install_path": "entry/build/default/outputs/default/entry-default-unsigned.hap"
}
```

2. 执行发版前检查：

```bash
bash scripts/release/pre_release_check.sh tests/config/device.example.json
```

## 当前内置用例

- P0 冒烟：
  - 首页加载
  - 统计页可达
- E2E 回归：
  - 默认时长保存后首页即时刷新
  - 开始专注流程可达确认页
  - 提前完成到结果页
  - 放弃到结果页
  - 结果保存并返回首页
  - 保存后统计页关键控件存在

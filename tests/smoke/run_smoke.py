#!/usr/bin/env python3
import subprocess
import sys
import argparse


def main() -> int:
  parser = argparse.ArgumentParser()
  parser.add_argument("--config", default="tests/config/device.example.json")
  args = parser.parse_args()
  cmd = [
    "python3",
    "tests/e2e/release_runner.py",
    "--config",
    args.config,
    "--mode",
    "smoke"
  ]
  return subprocess.call(cmd)


if __name__ == "__main__":
  sys.exit(main())

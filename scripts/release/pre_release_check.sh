#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT_DIR"

CONFIG_PATH="${1:-tests/config/device.example.json}"

echo "[1/3] Run smoke gate..."
python3 tests/smoke/run_smoke.py --config "$CONFIG_PATH" || {
  echo "Smoke gate failed. Release blocked."
  exit 1
}

echo "[2/3] Run e2e regression..."
python3 tests/e2e/release_runner.py --config "$CONFIG_PATH" --mode e2e || {
  echo "E2E regression failed. Release blocked."
  exit 1
}

echo "[3/3] Pre-release automation passed."
echo "Artifacts: artifacts/automation/"

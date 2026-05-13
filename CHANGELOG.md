# Changelog

All notable changes to this project will be documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/) principles.

## [Unreleased]

---

## [1.1.0] - 2026-05-13

### 摘要

应用版本 **1.1.0**（`AppScope/app.json5`）：修复设置默认专注时长后首页不即时刷新、专注结束重复触发风险；本地写入失败不再静默吞错。增加发版前自动化脚本与手册，并扩展手动回归条目。**不含**签名材料或构建产物提交。

### Added

- **`docs/testing/automation-playbook.md`**：发版前自动化分层与门禁说明。
- **`scripts/release/pre_release_check.sh`**、`tests/`：基于 `hdc` 与可选 `hmdriver2` 的冒烟与 E2E 入口（示例配置不含密钥）。

### Changed

- **`AppScope/app.json5`**：`versionName` 1.1.0，`versionCode` 1000100。
- **`.gitignore`**：忽略 `artifacts/` 与 Python `__pycache__` / `*.pyc`，降低误提交运行产物风险。

### Fixed

- **`HomePage`**：从统计设置返回后重新加载首页数据，默认时长即时一致。
- **`FocusPage`**：结束专注流程增加并发保护，降低重复跳转结果页概率。
- **`LocalStorageService`**：`putString` 失败时抛出 `Error`，避免上层误判保存成功。

---

## [0.1.1] - 2026-05-11

### 摘要

文档与开源维护小更新：对齐 Roadmap 表述、补充排障指南。**无**新核心业务功能、**无** UI 改动、**无**新依赖。

### Added

- **`docs/troubleshooting.md`**：DevEco 打开工程、SDK/API、`build-profile`、签名与真机、hvigor/ohpm 同步、协作勿提交敏感材料等说明。
- **`docs/releases/v0.1.1.md`**：本版本 Release 说明草稿。

### Changed

- **`CHANGELOG`**：将原 `[Unreleased]` 中的维护记录归入本节。
- **`.gitattributes`**：强化 `.ets` → TypeScript、辅助 `.py` 不参与语言主占比；README 中保留简短 Linguist 说明。
- **`docs/quickstart.md`**、`docs/project-structure.md`：前期精简版内容与导航延续；quickstart 增加 troubleshooting 链接。
- **`README`**：Run locally / 文档区链接 troubleshooting；Roadmap 摘要旁明确 **v0.2** 与 **v0.4（AI 拆解探索）** 分工（中英文一句）；文档索引补充 troubleshooting 与本 Release 说明。

---

## [0.1.0] - 2026-05-10

### Baseline（开源仓库整理）

本标签对应 **v0.1.x 基准开源版本**：本地专注闭环可运行，文档与社区治理文件齐备；**不表示**应用商店已上架。

### Added

- **文档**：`docs/quickstart.md`、`docs/roadmap.md`、`docs/project-structure.md`、`docs/release-checklist.md`、`docs/screenshots/README.md`、`docs/releases/v0.1.0.md`
- **协作**：`.github/ISSUE_TEMPLATE/`（Bug / Feature / Docs）、`.github/pull_request_template.md`
- **仓库元数据**：`.gitattributes`（语言统计与文本/二进制标记）、`.env.example`（占位说明）
- **协作说明**：扩展 `docs/ai-workflow.md`；更新 `CONTRIBUTING.md`、`SECURITY.md`

### Changed

- **README**：按基准版本与诚实功能边界重写；补充仓库链接、文档索引与 Roadmap 摘要；补充「Git 标签 vs 应用版本号」约定与 Release 文档链接
- **`docs/releases/v0.1.0.md`**：定稿发布说明，区分 **`v0.1.0` 开源快照**与 **`AppScope/app.json5`**（`versionName` / `versionCode`）
- **`.gitignore`**：补充常见 IDE、缓存与日志类忽略规则

### Security / hygiene

- 确认公开跟踪文件中不包含真实签名配置；本地 `build-profile.json5` 保持仅存在于被忽略路径（开发者自查）

---

## Earlier history

以下为迁移至本 changelog 结构前的开源基线整理记录（保留摘要以便溯源）。

### Added（历史）

- Open-source baseline documentation:
  - `CONTRIBUTING.md`
  - `SECURITY.md`
  - `AGENTS.md`
  - `docs/architecture.md`
  - `docs/harmonyos-release-checklist.md`
- MIT `LICENSE`

### Changed（历史）

- Hardened `.gitignore` for HarmonyOS signing files, build outputs, and local caches.
- Conservative publishing policy for scripts and internal docs paths.

### Security（历史）

- Identified local signing and path leakage risks for pre-open-source cleanup.

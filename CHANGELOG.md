# Changelog

All notable changes to this project are documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/) principles.

## [Unreleased]

### Changed

- **Linguist**：收紧 `.gitattributes`——强化 `*.ets` → TypeScript 覆盖、`*.py` 使用 `linguist-detectable=false`；README 简短说明语言统计与 `.ets` 的关系。
- **文档**：重写精简 `docs/quickstart.md`（DevEco/SDK、`build-profile` 模板、`entry` 运行）；`docs/project-structure.md` 改为每目录 1～2 句话。
- **README**：技术栈下补充 Linguist 说明；微调指向 quickstart / project-structure 的文案链接。

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

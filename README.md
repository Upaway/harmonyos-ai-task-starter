# Just Start · 开始做事

**口号：** 先开始，再做完。

一句话介绍：这是一套在 **HarmonyOS NEXT** 上可运行的、**本地优先**的专注与任务流基准工程；本仓库同时记录 **个人开发者借助 AI 协作**开发鸿蒙应用的过程与工程化取舍。

**仓库：** [Upaway/harmonyos-ai-task-starter](https://github.com/Upaway/harmonyos-ai-task-starter)

| 维度 | 说明 |
|------|------|
| **当前状态** | **Baseline version / 基准版本（v0.1.x）** — 可本地构建运行，文档与开源维护结构已对齐；**不等同于**应用商店上架版本。 |
| **应用形态** | HarmonyOS NEXT（Stage 模型）独立 App；无账号、无云同步（当前基准）。 |
| **方向** | 任务记录 / 番茄式专注闭环；后续迭代再探索 **AI 任务拆解**（尚未在本基准中实现）。 |
| **开源定位** | 真实工程的裁剪开源副本 + 协作记录，不是「用完即弃的 Demo」。 |

---

## 技术栈

- HarmonyOS NEXT（Stage 模型）
- ArkTS · ArkUI
- DevEco Studio **6.x**（与工程 `compatibleSdkVersion` 对齐）
- hvigor · ohpm
- 本地持久化：`Preferences`

---

## 功能状态（诚实边界）

| 状态 | 内容 |
|------|------|
| **已实现（基准）** | 任务输入 → 时长选择 → 开始确认 → 专注计时 → 单次结果；本地持久化；当日统计与近期记录；基础设置与统计页。 |
| **计划中** | 任务体验优化、专注流程打磨、上架所需合规与素材；AI 能力排在明确里程碑之后（见 [Roadmap](#roadmap)）。 |
| **探索中** | 与 AI 协作的工程方式、文档与发布流程；**不代表现有 App 已具备「智能拆解」等产品能力。** |

---

## 快速开始

1. 安装 **DevEco Studio** 与 HarmonyOS NEXT **SDK**（版本需与工程配置一致）。
2. 用 DevEco **打开本仓库根目录**。
3. **依赖同步**：按 IDE 提示执行 ohpm / Gradle（hvigor）同步。
4. **本地签名**：将 `build-profile.json5.template` 复制为 **`build-profile.json5`**（已被 `.gitignore` 忽略），仅在本地填入签名材料路径与加密口令；**勿将真实 `build-profile.json5`、证书、profile 提交到 GitHub。**
5. 选择 **`entry`** 模块，以 **Debug** 运行到真机或模拟器。

更细的步骤与故障排查见 **[`docs/quickstart.md`](docs/quickstart.md)**。

---

## 项目结构（概要）

| 路径 | 作用 |
|------|------|
| `AppScope/` | 应用级配置与资源（如图标、`app.json5`） |
| `entry/` | 主模块源码与模块级 `module.json5` |
| `docs/` | 架构说明、快速开始、路线图、发布检查项等 |
| `scripts/` | 辅助脚本（如图标相关生成，非运行时依赖） |
| 根目录 | `hvigorfile.ts`、`oh-package.json5`、`build-profile.json5.template` 等构建与工程配置 |

完整目录说明见 **[`docs/project-structure.md`](docs/project-structure.md)**。

---

## 截图

仓库内已包含若干示例截图（若你克隆后自行替换，请保持文件名或同步更新下方引用）：

| 画面 | 文件 |
|------|------|
| 首页 | [`docs/screenshots/home.jpg`](docs/screenshots/home.jpg) |
| 开始确认 | [`docs/screenshots/confirm.jpg`](docs/screenshots/confirm.jpg) |
| 专注中 | [`docs/screenshots/focus.jpg`](docs/screenshots/focus.jpg) |
| 统计与设置 | [`docs/screenshots/stats.jpg`](docs/screenshots/stats.jpg) |

维护说明与占位约定见 **[`docs/screenshots/README.md`](docs/screenshots/README.md)**。

---

## Roadmap

阶段目标（**不承诺时间节点**）见 **[`docs/roadmap.md`](docs/roadmap.md)**。摘要：

- **v0.1** — 基准版本：本地专注闭环可运行、工程与文档可复现。
- **v0.2** — 任务体验优化。
- **v0.3** — 番茄 / 专注体验完善。
- **v0.4** — AI 任务拆解探索。
- **v1.0** — 上架向稳定版本（合规、素材、质量门槛）。

---

## AI Collaboration Workflow

本仓库将 **AI 作为协作工具**（如 Cursor、Codex、ChatGPT 等），用于加速阅读、补文档、做小步重构与检查清单；**需求取舍、签名与上架决策、隐私与合规仍必须由人负责**。

详细分工与边界见 **[`docs/ai-workflow.md`](docs/ai-workflow.md)**；协作守则见根目录 **`AGENTS.md`**。

---

## 文档索引

| 文档 | 说明 |
|------|------|
| [`docs/quickstart.md`](docs/quickstart.md) | 环境、同步依赖、运行、常见问题 |
| [`docs/architecture.md`](docs/architecture.md) | 架构与模块边界 |
| [`docs/roadmap.md`](docs/roadmap.md) | 路线图 |
| [`docs/ai-workflow.md`](docs/ai-workflow.md) | AI 协作方式与边界 |
| [`docs/release-checklist.md`](docs/release-checklist.md) | 发布与开源检查项 |
| [`docs/harmonyos-release-checklist.md`](docs/harmonyos-release-checklist.md) | HarmonyOS 上架相关补充清单 |
| [`docs/releases/v0.1.0.md`](docs/releases/v0.1.0.md) | v0.1.0 Baseline 说明草稿 |
| [`CHANGELOG.md`](CHANGELOG.md) | 变更记录 |

---

## Contributing & Security

参与贡献前请阅读 **[`CONTRIBUTING.md`](CONTRIBUTING.md)** 与 **[`SECURITY.md`](SECURITY.md)**。早期阶段以 **文档改进、Issue 反馈、运行环境经验** 为主。

---

## License

MIT License — 见 [`LICENSE`](LICENSE)。

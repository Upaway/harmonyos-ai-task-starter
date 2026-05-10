# 项目结构说明

下文仅描述 **本仓库中真实存在** 的顶层目录与配置文件，便于新手建立心智模型。

## 顶层目录

| 路径 | 说明 |
|------|------|
| **`AppScope/`** | 应用级：全局 `app.json5`（如 `bundleName`、`versionName`）、应用图标与字符串等资源。 |
| **`entry/`** | 主入口模块：页面、组件、ViewModel、本地存储与 `module.json5`（模块能力、路由入口等）。 |
| **`docs/`** | 开源文档：快速开始、架构、路线图、发布检查项、`releases/` 下的版本说明、`screenshots/` 下的截图资源。 |
| **`scripts/`** | 开发与资源辅助脚本（如图标生成），**不参与** App 运行时逻辑。 |
| **`.github/`** | GitHub：Issue / PR 模板等社区维护文件。 |

## 根目录常见文件

| 文件 | 说明 |
|------|------|
| `hvigorfile.ts` | 工程级 hvigor 构建入口。 |
| `oh-package.json5` | ohpm 包元数据与依赖声明。 |
| `build-profile.json5.template` | **公开的安全模板**；本地复制为 `build-profile.json5` 后配置签名（后者勿提交）。 |
| `LICENSE` | 开源许可证（MIT）。 |
| `README.md` | 仓库说明与入口索引。 |
| `CHANGELOG.md` | 版本变更记录。 |
| `AGENTS.md` | 面向 AI 协作工具的仓库约定。 |

## `entry/src/main/ets/`（源码）

| 目录 | 说明 |
|------|------|
| `pages/` | 各路由页面。 |
| `components/` | 可复用 UI 组件。 |
| `viewmodels/` | 页面状态与用例编排。 |
| `models/` | 领域数据结构。 |
| `storage/` | 本地持久化访问。 |
| `constants/` | 文案、主题等常量。 |
| `utils/` | 工具函数。 |
| `entryability/` | Ability 入口。 |

更抽象的架构原则见 [`architecture.md`](architecture.md)。

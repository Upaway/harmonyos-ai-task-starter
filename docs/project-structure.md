# 项目结构说明

仅描述仓库里**真实存在**的路径，方便新手对照本地目录。

## 顶层目录

| 路径 | 说明 |
|------|------|
| **`AppScope/`** | 应用级配置与资源：如全局 `app.json5`（包名、版本号）、应用图标与字符串。 |
| **`entry/`** | 主业务模块：含 `src/main/ets` 源码、`module.json5`，以及 `src/main/resources` 下的路由与元素资源。 |
| **`docs/`** | 开源文档、版本说明（`releases/`）、截图（`screenshots/`）等。 |
| **`scripts/`** | 开发辅助脚本（例如图标 PNG 生成），不参与运行时。 |
| **`.github/`** | Issue / PR 模板等 GitHub 维护文件。 |

## 根目录常见文件（节选）

| 文件 | 一句话 |
|------|--------|
| `hvigorfile.ts` | 工程级 hvigor 构建入口。 |
| `oh-package.json5` | ohpm 包元数据与依赖。 |
| `build-profile.json5.template` | 可提交的签名配置模板；本地复制为 `build-profile.json5` 后自行填写，勿提交后者。 |

## `entry/src/main/ets/`（ArkTS 源码）

| 目录 | 一句话 |
|------|--------|
| **`pages/`** | 各页面 UI（首页、确认、专注、结果、统计设置等）。 |
| **`components/`** | 可复用组件（含 `components/ui/` 子目录）。 |
| **`viewmodels/`** | 页面状态与流程逻辑，与 `pages` 配合。 |
| **`models/`** | 任务、会话、统计等数据模型。 |
| **`storage/`** | 读写本地 `Preferences` 等持久化封装。 |
| **`constants/`** | 文案、主题色、路由常量等。 |
| **`utils/`** | 时间、校验、统计等工具函数。 |
| **`entryability/`** | `EntryAbility` 等 Ability 入口。 |

## `entry/src/main/resources/`

放模块级 **路由表**（如 `base/profile/main_pages.json`）与 **颜色、字符串**（`base/element/`），供 ArkUI 引用。

更抽象的分层说明见 [`architecture.md`](architecture.md)。

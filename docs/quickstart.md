# 快速开始（Just Start）

面向在本机 **首次打开工程** 的开发者；**不包含**任何真实签名文件或口令。

## 环境要求

- **操作系统**：Windows / macOS（与 DevEco Studio 支持列表一致）。
- **DevEco Studio**：建议 **6.x**，且已在 SDK Manager 中安装与本工程一致的能力包。本仓库模板中的产品与 SDK 对齐关系为 **`compatibleSdkVersion` / `targetSdkVersion`: `6.0.2(22)`**（见根目录 [`build-profile.json5.template`](../build-profile.json5.template)）；若你本地使用更高 API，需自行验证兼容性。
- **设备**：HarmonyOS NEXT 真机（开发者模式/USB 调试）或官方模拟器。

## 打开项目

1. 克隆仓库：
   ```bash
   git clone https://github.com/Upaway/harmonyos-ai-task-starter.git
   cd harmonyos-ai-task-starter
   ```
2. 使用 **DevEco Studio** → **Open** → 选择仓库**根目录**（包含 `hvigorfile.ts`、`AppScope/`、`entry/` 的那一层）。

## 同步依赖

- 打开工程后，按 IDE 提示执行 **Sync**（hvigor / ohpm 会根据 `oh-package.json5` 等拉取依赖）。
- 若同步失败，检查 **SDK Manager** 中 API 版本是否与工程一致，以及网络与代理设置。

## 本地签名（不要提交）

1. 在仓库**根目录**将模板复制为本地配置文件（文件名固定为 `build-profile.json5`）：
   ```text
   build-profile.json5.template  →  build-profile.json5
   ```
   `build-profile.json5` 已被 `.gitignore` 忽略，**不会**进入 `git status` 的默认提交集。
2. 仅在**本机**用 DevEco / 文档指引填写：
   - keystore / profile 路径（建议放在被 `.gitignore` 覆盖的 `cert/` 等目录）；
   - DevEco 生成的 **加密后** `storePassword` / `keyPassword`（勿使用明文占位直接上架）。
3. **切勿**将 `build-profile.json5`、`.p12`、`.p7b`、`.cer` 等推送到公开仓库（本仓库已在 `.gitignore` 中忽略常见路径）。

> 公开协作时只保留 **`build-profile.json5.template`** 与文档说明即可。

## 运行到真机或模拟器

1. 连接设备或启动模拟器。
2. 在 DevEco 中选择 **`entry`** 模块。
3. 使用 **Run**（Debug）安装并启动。
4. 建议跑通：`首页输入任务` → `确认时长` → `专注` → `结束结果` → `统计页`，并杀进程再开验证本地数据是否仍在。

## 常见问题

| 现象 | 可能原因 | 建议 |
|------|----------|------|
| 同步失败 / SDK 报错 | SDK 版本与工程不一致 | 对齐 `compatibleSdkVersion`，重装对应 API |
| 安装失败 | 签名或 profile 无效 | 检查本地 `build-profile.json5` 与华为开发者后台 profile |
| 运行闪退 | 权限或设备兼容性 | 查看 Log；基准版仅声明必要权限，见 `entry/src/main/module.json5` |
| 找不到模块 | 打开了错误目录 | 确保打开的是含 `AppScope` 与 `entry` 的根目录 |

## 与开源安全相关的说明

- 本基准 **不使用** `.env` 加载云端密钥（参见根目录 `.env.example`）。
- 任何 PR **不得**包含真实 Token、证书、私钥、个人身份号码或他人隐私数据。
- 更完整的发布前自查见 [`release-checklist.md`](release-checklist.md)。

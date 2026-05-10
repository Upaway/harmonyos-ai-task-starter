# 快速开始（Just Start）

面向在本机 **首次打开工程** 的开发者；文中**不包含**任何真实签名文件或口令。

## DevEco Studio / HarmonyOS NEXT SDK 要求

- **DevEco Studio**：建议使用 **6.x**（与华为当前 HarmonyOS NEXT 工具链一致）。
- **HarmonyOS NEXT SDK**：在 IDE 的 **SDK Manager** 中安装与本工程 **API 级别一致** 的能力包。本仓库产品与 SDK 的对应关系见根目录 [`build-profile.json5.template`](../build-profile.json5.template) 中的 **`compatibleSdkVersion` / `targetSdkVersion`**（当前模板为 **`6.0.2(22)`**）。
- **操作系统**：Windows / macOS（以 DevEco 官方支持列表为准）。
- **运行设备**：HarmonyOS NEXT **真机**（开启开发者模式与 USB 调试）或 **官方模拟器**。

若本地 SDK 高于模板所列版本，需自行验证构建与运行是否正常。

## 打开项目

1. 克隆仓库：
   ```bash
   git clone https://github.com/Upaway/harmonyos-ai-task-starter.git
   cd harmonyos-ai-task-starter
   ```
2. 启动 **DevEco Studio** → **Open**，选择**仓库根目录**（该目录下应直接可见 `hvigorfile.ts`、`AppScope/`、`entry/`）。

## 同步依赖

打开工程后按提示完成 **Sync Project**（hvigor / ohpm 会根据 `oh-package.json5` 等拉取依赖）。失败时请检查 SDK 是否安装完整、网络与代理。

## 复制 `build-profile.json5.template`（勿提交真实签名）

1. 在**仓库根目录**将模板复制为本地文件名 **`build-profile.json5`**：
   ```text
   build-profile.json5.template  →  build-profile.json5
   ```
2. 仅在**本机**填写 keystore、profile 路径及 DevEco 生成的 **加密后**口令字段（勿把明文口令写入仓库）。
3. **`build-profile.json5`、`.p12`、`.p7b`、`.cer` 等切勿提交**；本仓库已通过 `.gitignore` 忽略常见本地签名路径。公开协作只保留 **`build-profile.json5.template`**。

## 运行 `entry` 模块

1. 连接真机或启动模拟器。
2. 在 DevEco 运行配置中选择 **`entry`** 模块（主入口模块）。
3. 使用 **Run**（建议 **Debug**）编译、安装并启动应用。
4. 建议手动跑通：首页输入任务 → 确认时长 → 专注计时 → 结果页 → 统计页；并**强制停止进程后重启**，确认本地数据仍在。

更完整的发布前自查见 [`release-checklist.md`](release-checklist.md)。

## 常见问题（节选）

| 现象 | 建议 |
|------|------|
| 同步 / SDK 报错 | 对齐 `compatibleSdkVersion`，在 SDK Manager 中补齐对应 API |
| 安装失败 | 检查本地 `build-profile.json5` 与华为后台 Profile 是否匹配 |
| 找不到模块 | 确认打开的是含 `AppScope` 与 `entry` 的根目录 |

## 开源安全提醒

- 本基准不依赖 `.env` 中的云端密钥（参见根目录 `.env.example`）。
- 任何 PR **不得**包含 Token、证书、私钥或他人隐私信息。

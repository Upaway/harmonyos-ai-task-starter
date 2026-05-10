# 故障排查（Just Start）

面向首次在本机构建运行的开发者。本文只列**常见现象与排查方向**，不替代华为官方文档。

---

## DevEco Studio 无法打开项目

- **是否打开了正确目录**：应选择包含 `hvigorfile.ts`、`AppScope/`、`entry/` 的**仓库根目录**，不要只打开 `entry/` 子文件夹。
- **DevEco 版本过旧或过新**：建议使用 **6.x**，并与工程模板中的 SDK 版本对齐；版本不匹配时可能无法识别工程或同步失败。
- **工程损坏或克隆不完整**：删目录后重新 `git clone`，不要在不完整的压缩包上打开。

---

## HarmonyOS SDK / API 版本不一致

- 对照根目录 [`build-profile.json5.template`](../build-profile.json5.template) 中的 **`compatibleSdkVersion` / `targetSdkVersion`**（当前模板示例为 **`6.0.2(22)`**）。
- 打开 **SDK Manager**，安装对应 API 与工具链；缺失组件时同步常会报错。
- 若本机仅安装了更高版本 API，可能仍报错——按 IDE 提示补齐**精确匹配**的能力包，或在理解风险的前提下自行调整本地配置（不推荐在未搞清影响前随意改模板中的版本号）。

---

## `build-profile.json5` 不存在

- 仓库只提供 **`build-profile.json5.template`**；必须在**本地**复制为 **`build-profile.json5`**（文件名固定）。
- 若从未复制，Release/Debug 安装阶段可能失败。**不要**把个人的 `build-profile.json5` 提交到 Git。

---

## 签名文件缺失或配置错误

- 本地需具备：**Profile（`.p7b`）**、**证书（`.cer`）**、**密钥库（`.p12`）** 等（具体以华为开发者后台为准），并在 `build-profile.json5` 中填写**正确相对路径**与 DevEco 生成的加密口令字段。
- **路径错误**、**profile 过期**、**包名与 profile 不一致**都会导致构建或安装失败——需在开发者后台核对应用 ID / bundleName 与工程 [`AppScope/app.json5`](../AppScope/app.json5) 一致。
- **不要将** `.p12`、`.p7b`、`.cer`、私钥或明文口令放进仓库或 Issue 附件。

---

## 真机运行失败

- **USB 调试 / 开发者模式**是否开启；数据线是否支持数据传输。
- **设备系统版本**是否与目标 SDK 兼容（见 DevEco Device Manager 中的设备信息）。
- **签名与设备**：调试包通常使用调试证书；若改用错误 profile，可能出现安装失败或启动失败。
- 查看 **Build / Run 日志**中的具体错误码或英文提示，再对照华为文档检索。

---

## ohpm / hvigor 同步失败

- **网络与代理**：企业网络或防火墙可能阻断依赖下载；尝试切换网络或配置 IDE 代理。
- **SDK 未装全**：同步依赖前应先解决 SDK 组件缺失。
- **缓存异常**：在明确风险前提下，可清理本地 `.hvigor`、`.ohos` 等缓存目录（勿提交这些目录）；必要时关闭工程后重新 Open 再 Sync。
- 具体命令与路径以当前 DevEco / hvigor 版本文档为准。

---

## 仓库协作：不要提交的内容

以下材料**禁止**进入公开 PR 或 Issue：

- 真实 **`.env`**（含密钥）、**Token**、**Cookie**、云 API Key  
- **`build-profile.json5`**（含本地路径与口令字段）、**证书**、**私钥**、**真实 Profile**  
- **他人隐私**、含敏感信息的**完整日志或截图**

说明材料可用**占位符**或**脱敏路径**。详见 [`SECURITY.md`](../SECURITY.md)。

---

## 仍有问题时

1. 先走完 [`quickstart.md`](quickstart.md) 中的步骤与自检。  
2. 查阅 [`release-checklist.md`](release-checklist.md) 中与签名、版本相关的条目。  
3. 向仓库提 Issue 时附上：**DevEco 版本、SDK/API、错误摘要**（勿贴密钥与证书全文）。

# Contributing to Just Start

感谢你愿意花时间改进「开始做事 / Just Start」仓库。早期阶段我们更希望收到 **可执行的反馈** 与 **小步可审的改动**。

## 项目处于什么阶段

- 这是一套 **HarmonyOS NEXT** 上的真实工程开源副本，基准能力见 [`README.md`](README.md) 与 [`docs/roadmap.md`](docs/roadmap.md)。
- **优先欢迎**：文档纠错、`docs/` 补充、Issue 里可复现的构建/运行问题、与里程碑一致的小型修复。
- **大块功能或架构重写**：请先开 Issue 对齐范围，避免与维护者当前里程碑冲突。

## 开始前请阅读

- [`README.md`](README.md)
- [`AGENTS.md`](AGENTS.md)
- [`docs/architecture.md`](docs/architecture.md)
- [`SECURITY.md`](SECURITY.md)

## 本地开发（提要）

1. 安装 DevEco Studio **6.x** 与对应 HarmonyOS NEXT SDK。
2. 打开仓库根目录并同步依赖。
3. 复制 `build-profile.json5.template` 为本地 `build-profile.json5`（**勿提交**），配置签名。
4. 运行 `entry` 模块做手动验证。

详见 [`docs/quickstart.md`](docs/quickstart.md)。

## 如何提交 Issue

- **Bug**：尽量给出 SDK 版本、设备/模拟器信息、复现步骤；**不要**粘贴密钥或证书内容。
- **功能建议**：说明场景与期望；接受维护者因路线图暂不接 PR 的决定。
- **文档**：指出路径与具体问题，欢迎直接给出修改草稿。

可使用 `.github/ISSUE_TEMPLATE/` 下的模板。

## 如何提交 Pull Request

1. **一次 PR 聚焦一类变更**（文档 / 修复 / 小型改进），便于审查。
2. 填写 PR 描述，勾选 [`.github/pull_request_template.md`](.github/pull_request_template.md) 中的自检项。
3. **禁止**在 PR 中包含：真实签名文件、`build-profile.json5`、Token、私钥、证书、他人隐私或未脱敏日志。
4. 用户可见行为变化请更新 [`CHANGELOG.md`](CHANGELOG.md)。

### Commit 消息前缀（建议）

- `feat:` 新功能  
- `fix:` 缺陷修复  
- `refactor:` 不改变行为的结构调整  
- `docs:` 仅文档  
- `chore:` 工具链 / 仓库维护  

## 安全与敏感信息

请勿在公开 Issue / PR 中披露漏洞细节或上传敏感附件；请先阅读 [`SECURITY.md`](SECURITY.md)。

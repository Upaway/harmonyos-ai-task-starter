# Security Policy

## 适用范围

本仓库为开源 HarmonyOS 应用工程，安全相关关注点包括但不限于：

- 签名、证书与华为开发者侧配置的外泄
- 误提交的 Token、API Key、明文口令、隐私数据
- 本地持久化数据暴露边界（当前基准以设备本地为主）

## 如何报告安全问题

1. **请勿**在公开 Issue / 讨论中粘贴密钥、证书全文、可利用细节或未授权获取的用户数据。
2. 请先通过 **私有渠道** 联系维护者（若仓库尚未配置专用安全邮箱，可开一个 **不含细节** 的 Issue，仅请求私下联络方式）。
3. 报告内容建议包含：**影响范围**、**复现思路（高层次）**、**受影响版本或提交**，避免附带攻击性 payload。

维护者会在合理时间内确认收到并协调修复与披露节奏。

## 不要提交到本仓库的内容

以下材料 **禁止** 出现在 Issue、PR 或公开附件中：

- `build-profile.json5`（真实签名配置）、`.p12`、`.p7b`、`.cer`、`.pem`、私钥、keystore
- 任何云端 **API Key / Token / Cookie**、明文账号口令
- **身份证、银行卡、未脱敏手机号** 等个人敏感信息
- 含上述内容的日志或截图

若 PR 误含敏感信息，维护者将 **拒绝合并** 并要求删除或轮换已泄露的凭证；严重情况可能请求 GitHub 协助移除历史记录。

## 协作建议

- 公开仓库仅保留 **`build-profile.json5.template`** 与说明文档；本地签名目录由 `.gitignore` 排除。
- 轮换任何曾经出现在聊天、截图或误提交中的凭证。
- 上架与合规材料中的隐私义务由开发者自行承担，本开源仓库不替代法务审查。

## 加固参考

- 发布与开源自查：[`docs/release-checklist.md`](docs/release-checklist.md)
- HarmonyOS 上架补充：[`docs/harmonyos-release-checklist.md`](docs/harmonyos-release-checklist.md)

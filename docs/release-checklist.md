# 发布与开源检查清单

适用于：**本地打包验证**、**GitHub 推送前自查**、**面向商店上架的准备**（后两类侧重点不同，请逐项勾选）。

## A. 打包前（工程）

- [ ] 工程可在 DevEco 中 **Clean** 后重新 **Build** 通过。
- [ ] `entry` 模块安装到目标设备/模拟器后，核心路径可手动跑通（参见 [`releases/v0.1-manual-test.md`](releases/v0.1-manual-test.md)）。
- [ ] 无已知阻塞级崩溃（若有，记录在 Issue / Release Note）。

## B. 标识与版本

- [ ] **`bundleName`**：与 [`AppScope/app.json5`](../AppScope/app.json5) 及上架后台一致（未经评审勿改）。
- [ ] **`app_name` / 应用显示名**：与资源 [`AppScope/resources/base/element/string.json`](../AppScope/resources/base/element/string.json)（及模块字符串）一致。
- [ ] **`versionCode` / `versionName`**：已递增且与对外 Release Note 一致。

## C. 权限

- [ ] [`entry/src/main/module.json5`](../entry/src/main/module.json5) 及Ability声明与 **实际使用** 一致。
- [ ] 未擅自增加敏感权限（如无关网络、通讯录等）；若新增，必有产品与合规评审。

## D. 敏感信息与仓库卫生

- [ ] 未提交：`build-profile.json5`、`.p12`、`.p7b`、私钥、明文口令、AppGallery 密钥。
- [ ] 无个人身份证、手机号、非公开邮箱（除非刻意公开的联络方式且已评审）。
- [ ] 无开发者机器 **绝对路径** 泄露在已跟踪文件中（签名路径可用相对路径或文档说明）。
- [ ] `.gitignore` 仍覆盖构建产物、hvigor 缓存、IDE 局部配置等。

## E. 截图与上架材料（面向商店时）

- [ ] 截图反映 **当前版本** 真实 UI（分辨率与文案更新及时）。
- [ ] 图标与商店物料符合平台规范（参见官方文档与内部素材清单）。
- [ ] 隐私政策、用户协议链接有效（若已上架或提交审核）。

## F. README 与 Release Note

- [ ] [`README.md`](../README.md) 中「已实现 / 计划中」与代码一致，无夸大 AI 能力。
- [ ] [`CHANGELOG.md`](../CHANGELOG.md) 已更新对应版本。
- [ ] 若有 GitHub Release：说明包含内容、已知限制、安装/运行前提。

## G. 参考

- HarmonyOS 侧更细的「可运行 MVP vs 上架」拆分见 [`harmonyos-release-checklist.md`](harmonyos-release-checklist.md)。

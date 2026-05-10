# AGENTS Guide (Cursor / Codex / Claude Code)

This document defines how AI coding agents should collaborate in this repository.

## Project Goal

`Just Start` is a HarmonyOS NEXT productivity app template:

- v0.1: local-first baseline — Pomodoro-style focus loop (no AI/account/cloud in shipped baseline)
- v0.2: task experience improvements
- v0.3: focus / Pomodoro experience refinements
- v0.4: AI task decomposition exploration (not committed until scoped)
- v1.0: store-facing stability and compliance hardening

Details and non-goals: `docs/roadmap.md`. Always keep the current milestone boundary explicit.

## Tech Stack

- HarmonyOS NEXT (Stage model)
- ArkTS + ArkUI
- DevEco Studio + hvigor + ohpm
- Local persistence via `Preferences`

## Code Style and Change Rules

- Keep changes minimal and focused.
- Follow existing module boundaries (`pages`, `components`, `viewmodels`, `storage`, `utils`).
- Prefer readability over clever abstractions.
- Add brief comments only when logic is non-obvious.
- Avoid introducing broad refactors in feature/fix PRs.

## Forbidden / Restricted Changes

- Do not commit real signing materials:
  - `cert/`, `*.p12`, `*.p7b`, `*.cer`, `*.pem`, `*.key`, `*.jks`, `*.keystore`
- Do not commit real tokens, API keys, passwords, or private profile files.
- Do not hardcode machine-local absolute paths in docs/configs.
- Do not modify release/security posture without updating related docs.

## Pre-Change Checklist (Required)

Before editing:

1. Confirm the requested scope (v0.1, v0.2, or release docs).
2. Check for secret leakage risk in touched files.
3. Verify no ignored artifacts are being staged accidentally.
4. For HarmonyOS config updates, inspect:
   - `build-profile.json5`
   - `AppScope/app.json5`
   - `entry/src/main/module.json5`
5. Update docs when behavior/process changes.

## HarmonyOS Build and Release Notes

- Distinguish two states:
  - **MVP runnable** (local debug flow complete)
  - **AppGallery releasable** (signed package + compliance materials complete)
- Local build success does not imply AppGallery readiness.
- Keep signing values sanitized in open-source branch.

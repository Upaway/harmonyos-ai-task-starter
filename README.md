# Just Start (开始做事)

## Project Status

This repository is currently an open-source baseline for Just Start / 开始做事.

- v0.1: local-first Pomodoro and focus workflow
- v0.2: AI-assisted task decomposition is planned
- No account system, no cloud sync, no sensitive permissions in the current baseline

`Just Start` is an open-source HarmonyOS NEXT productivity app template focused on:

- Pomodoro / focus timer
- local-first task management
- AI-assisted task decomposition workflow (planned in v0.2)
- solo developer AI collaboration case study

The project goal is to provide a practical, real-world template for building AI-first efficiency apps on HarmonyOS NEXT.

## Screenshots

Screenshots will be added under `docs/screenshots/`. Placeholder links:

- `docs/screenshots/home.png` (Home)
- `docs/screenshots/focus.png` (Focus Session)
- `docs/screenshots/result.png` (Session Result)
- `docs/screenshots/stats.png` (Stats / Settings)

## Features

- Focus flow: task input -> duration selection -> start confirmation -> focus timer -> result
- 25/50 minute quick presets and custom focus flow
- Local persistence for sessions and preferences
- Daily stats summary and recent session records
- Stage-model HarmonyOS NEXT app architecture with modular ArkTS code

## Tech Stack

- HarmonyOS NEXT (Stage model)
- ArkTS + ArkUI
- DevEco Studio 6.x
- hvigor / ohpm toolchain
- Local storage (`Preferences`) for persistence

## Run Locally

1. Install DevEco Studio and HarmonyOS NEXT SDK.
2. Open this repository in DevEco Studio.
3. Copy `build-profile.json5.template` to local `build-profile.json5` and fill your own signing values (local only, never commit).
4. Ensure your local SDK matches project config (`compatibleSdkVersion` / `targetSdkVersion`).
5. Run the `entry` module in Debug mode on a HarmonyOS device or emulator.

For open-source baseline docs, see:

- `docs/architecture.md`
- `docs/harmonyos-release-checklist.md`

## Project Structure

```text
AppScope/
entry/
docs/
scripts/
```

`entry/src/main/ets/`:

```text
pages/
components/
models/
viewmodels/
storage/
constants/
utils/
entryability/
```

## AI Collaboration Workflow

This repository is designed for AI-assisted iteration with tools like Cursor, Codex, and Claude Code:

- keep changes small and verifiable
- preserve V0.1 scope before expanding AI features
- separate MVP readiness from AppGallery release readiness
- document decisions in `docs/` and `CHANGELOG.md`

See `AGENTS.md` for collaboration rules.

## HarmonyOS Packaging and Release Notes

- Do not commit real signing materials (`.p12`, `.p7b`, `.cer`, `.pem`, `cert/`).
- Keep `build-profile.json5` sanitized before open-source publishing.
- Release/signing checklist: `docs/harmonyos-release-checklist.md`
- AppGallery notes should be maintained in private release docs outside this public baseline.

## Roadmap

- **v0.1**: local-first Pomodoro loop, stable MVP flow (no AI/account/cloud)
- **v0.2**: AI-assisted task decomposition, start suggestion, one-line reflection
- **v0.3**: AppGallery readiness and release hardening

## Contributing

Please read `CONTRIBUTING.md` and `SECURITY.md` before opening PRs.

## License

MIT License. See `LICENSE`.

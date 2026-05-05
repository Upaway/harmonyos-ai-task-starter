# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog principles.

## [Unreleased]

### Added

- Open-source baseline documentation:
  - `CONTRIBUTING.md`
  - `SECURITY.md`
  - `AGENTS.md`
  - `docs/architecture.md`
  - `docs/harmonyos-release-checklist.md`
- MIT `LICENSE`

### Changed

- Hardened `.gitignore` for HarmonyOS signing files, build outputs, and local caches.
- Adopted conservative publishing policy:
  - ignore all `.sh` scripts by default
  - publish only selected `docs/` files in open-source baseline
- Reworked `README.md` for open-source positioning and GitHub onboarding.

### Security

- Identified local signing and path leakage risks for pre-open-source cleanup.

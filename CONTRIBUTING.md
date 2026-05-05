# Contributing to Just Start

Thanks for contributing to `Just Start` (HarmonyOS NEXT productivity template).

## Before You Start

- Read `README.md`, `AGENTS.md`, and `docs/architecture.md`.
- Keep scope aligned with current milestone (v0.1 first, then v0.2 AI features).
- Do not commit secrets, certificates, signing profiles, or local machine configs.

## Development Setup

1. Install DevEco Studio 6.x and required HarmonyOS NEXT SDK packages.
2. Open the repo and sync dependencies.
3. Run the `entry` module in Debug mode on emulator or device.

## Contribution Principles

- Make small, reviewable PRs.
- Prefer one logical change per PR.
- Keep business behavior stable unless the PR explicitly targets behavior updates.
- Update docs when changing architecture, workflow, or release process.

## Pull Request Checklist

- [ ] Code builds in local DevEco Studio
- [ ] Manual flow is still working (task -> focus -> result -> stats)
- [ ] No signing material or secret is included
- [ ] Documentation updated if needed
- [ ] `CHANGELOG.md` updated for user-visible changes

## Commit Style

Recommended prefixes:

- `feat:` new feature
- `fix:` bug fix
- `refactor:` non-functional structural changes
- `docs:` documentation only
- `chore:` maintenance / tooling
- `test:` tests or validation scripts

## Security Reporting

Please do not open public issues for security vulnerabilities.
Follow `SECURITY.md` for responsible disclosure.

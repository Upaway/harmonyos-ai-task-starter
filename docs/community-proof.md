# Community Proof (Open Source Maintainer Evidence)

This page documents public, verifiable signals showing how the project is maintained and how external feedback is folded back into the repository.

## 1) Public project surface

- Repository: [Upaway/harmonyos-ai-task-starter](https://github.com/Upaway/harmonyos-ai-task-starter)
- Current milestone boundary: local-first baseline (`v0.1.x`), no account/cloud in baseline
- Maintainer context: single maintainer, frequent documentation and release-hygiene updates

## 2) Maintainer activity evidence

- Release notes:
  - [`docs/releases/v0.1.0.md`](releases/v0.1.0.md)
  - [`docs/releases/v0.1.1.md`](releases/v0.1.1.md)
- Change history:
  - [`CHANGELOG.md`](../CHANGELOG.md)
- Collaboration and contribution policy:
  - [`CONTRIBUTING.md`](../CONTRIBUTING.md)
  - [`AGENTS.md`](../AGENTS.md)

These files are intended to make maintenance cadence, project boundaries, and collaboration rules auditable.

## 3) External audience and feedback loop

This section keeps external audience signals conservative and privacy-aware.

### Xiaohongshu series links

- Series home / profile link: <https://www.xiaohongshu.com/user/profile/5e3f975b0000000001007083>
- Representative post links are not listed yet because the current evidence package uses creator-owned screenshots. If public post URLs become stable and accessible, they can be added here later.

### Public engagement snapshot

- Time window: captured on 2026-05-11.
- Aggregate reads/views: not claimed publicly because no analytics dashboard screenshot is being published.
- Aggregate interactions: only representative post-level interactions are summarized below.

Do not include private dashboards or non-public screenshots in the repository.

### Evidence from current screenshots (privacy-sanitized summary)

The maintainer provided three Xiaohongshu screenshots as private evidence material:

- Profile/notes overview screenshot shows a HarmonyOS-focused creator profile and two related posts.
- Post A (`做鸿蒙 App 的第二步，先把代码摊开`) shows:
  - public visibility marker
  - interaction signals: about `5` likes, `1` save, `0` comments (at capture time)
  - explicit repository mention: `Upaway/harmonyos-ai-task-starter`
- Post B (`一个人做鸿蒙 App，Vibe Coding 真的能跑通吗？`) shows:
  - public visibility marker
  - interaction signals: about `3` likes, `2` saves, `1` comment (at capture time)

Note: these are point-in-time signals from creator-owned screenshots. They should be described conservatively in external applications and shared only when appropriate.

## 4) Mapping: content -> repository updates

| Content topic | Repository artifact |
|---|---|
| Environment setup pitfalls | [`docs/quickstart.md`](quickstart.md), [`docs/troubleshooting.md`](troubleshooting.md) |
| Version boundary clarification | [`README.md`](../README.md), [`docs/roadmap.md`](roadmap.md) |
| Baseline/release maintenance | [`docs/releases/v0.1.0.md`](releases/v0.1.0.md), [`docs/releases/v0.1.1.md`](releases/v0.1.1.md), [`CHANGELOG.md`](../CHANGELOG.md) |

## 5) Suggested usage in grant applications

When applying for maintainer programs, link this page as an index and reference:

1. Why the project matters for a specific developer segment.
2. What the maintainer actually maintains on a recurring basis.
3. How external audience feedback turns into repository changes.

Suggested wording:

> The project is accompanied by a public HarmonyOS solo-dev content series. Representative posts show early organic engagement and direct references to the repository. Feedback themes (setup friction, project boundaries, release clarity) are continuously folded back into repository docs and maintenance notes.

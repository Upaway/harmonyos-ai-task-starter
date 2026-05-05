# AI Workflow (Solo Developer)

## Goal

Use AI coding agents to improve delivery speed while keeping quality and security under control.

## Recommended Loop

1. Define a small, testable task.
2. Ask agent to inspect only relevant files.
3. Apply minimal patch.
4. Run manual verification for key flow.
5. Update docs/changelog if behavior changed.

## Prompting Principles

- Be explicit about scope and non-goals.
- Specify "do not touch business logic" when doing infra/docs chores.
- Request security scan before release-related work.
- Ask for risk list and alternatives before deleting sensitive config.

## Safety Guardrails

- Never paste real secrets into prompts.
- Require agent to flag hardcoded credentials and local paths.
- Keep signing files and profile materials local-only.
- Review diffs before commit.

## Suggested Task Split

- PR 1: repository hygiene (`.gitignore`, docs baseline)
- PR 2: build/release scripts cleanup
- PR 3: feature work (v0.1 bug fix or v0.2 AI capability)

## Definition of Done (Per Change)

- scope matched request
- no secret leakage
- manual flow still works
- docs updated where needed
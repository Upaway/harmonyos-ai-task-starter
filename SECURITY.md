# Security Policy

## Supported Scope

This repository is an open-source HarmonyOS NEXT template project.
Security-sensitive areas include:

- signing and certificate handling
- API key / secret management
- local data persistence
- release packaging workflows

## Reporting a Vulnerability

Please report vulnerabilities privately first.

- Do not post secrets or exploit details in public issues.
- Provide reproduction steps, affected files, and impact summary.

If no dedicated security contact is configured yet, open a minimal issue asking maintainers for a private channel, without disclosing details.

## Secret Handling Rules

- Never commit real certificates, profiles, or private keys.
- Never commit real tokens, API keys, account passwords, or machine-local paths with sensitive context.
- Use templates/placeholders (for example, `build-profile.json5.template`) for public repos.

## Hardening Recommendations

- Rotate any credential that has appeared in git history.
- Keep signing materials in local-only directories excluded by `.gitignore`.
- Validate release artifacts before AppGallery submission.

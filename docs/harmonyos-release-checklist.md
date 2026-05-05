# HarmonyOS Release Checklist

This checklist separates **runnable MVP** from **AppGallery release**.

## A. Runnable MVP (v0.1)

- Core flow works end-to-end:
task input -> confirm -> focus -> result -> stats
- Local persistence works after app restart
- Manual test checklist passes (`docs/releases/v0.1-manual-test.md`)
- App runs on at least one target device/emulator

## B. Security and Repo Hygiene (Open Source)

- `.gitignore` covers signing files, certs, profile, build outputs
- No real secrets in repo (`token`, `password`, `api key`, private paths)
- No real cert/profile files are tracked
- `build-profile.json5` is sanitized (or replaced by safe template)

## C. Release Packaging (Local)

- Versioning checked in `AppScope/app.json5`
- Signing config verified locally (not committed publicly)
- Release package builds successfully
- Artifact signature verification passes

## D. AppGallery Submission Readiness

- Privacy policy and user agreement prepared
- Store icon and screenshots prepared
- App description, changelog, and category filled
- Permissions and data usage explanations reviewed
- Submission package and rollback plan prepared

## Notes

- Passing section A does not imply section D is ready.
- Keep signing material outside public repository history.
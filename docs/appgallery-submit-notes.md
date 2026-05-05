# AppGallery Submit Notes

This note is for release preparation and submission tracking.

## 1) Submission Inputs

- Signed release artifact (`.app` / `.hap`)
- Application icon and screenshots
- App name, summary, full description, category, keywords
- Privacy policy URL and user agreement
- Version update notes

## 2) Compliance Notes

- Ensure declared permissions are minimal and justified.
- Keep data collection statements consistent with actual behavior.
- Verify all third-party dependencies and licenses.

## 3) Technical Validation

- Validate package signature and integrity.
- Test install/launch on target HarmonyOS versions.
- Confirm upgrade path from previous version where applicable.

## 4) Common Pitfalls

- Submitting with mismatched profile/certificate/bundle info
- Missing or invalid privacy policy links
- Store assets that do not match required dimensions/spec
- Confusing "local debug success" with "release readiness"

## 5) Open-Source Branch Safety

- Do not include real release certificates/profiles.
- Keep release secrets in local secure storage only.
- Use templates and docs for configuration guidance.
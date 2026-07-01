# Production Readiness Checklist

This document outlines the required and recommended steps to ensure **Reflect** is fully prepared for a production release on the App Store and Google Play, beyond feature completeness.

## 1. Crash Reporting & Observability
Currently, if Reflect crashes on a user's device, we have no visibility into the issue.

- [ ] **Integrate Firebase Crashlytics or Sentry**: Catch unhandled Dart exceptions and native crashes.
- [ ] **Global Error Handlers**: Update `main.dart` to capture `FlutterError.onError` and `PlatformDispatcher.instance.onError` to route UI and async errors to the reporting tool instead of silently failing.

## 2. Data Portability / Manual Backups
Because we correctly disabled Android auto-backups (`allowBackup="false"`) to secure the SQLCipher database, users have no way to recover their tasks if they get a new phone or accidentally uninstall the app.

- [ ] **Export Data Feature**: Allow users to export their database to a JSON or CSV file.
- [ ] **Secure Cloud Backup (Optional)**: Allow users to back up an encrypted snapshot of their database to their personal Google Drive or iCloud.

## 3. State Restoration (App Lifecycle)
If a user is halfway through typing a long Daily Review and switches to another app, the OS might kill Reflect to free up RAM.

- [ ] **Implement `RestorationMixin`**: Apply to critical forms and scroll views so that the OS can seamlessly restore the user's state if the app is killed in the background.

## 4. Over-The-Air (OTA) Updates
App Store and Play Store review times can take days. If a critical bug makes it to production, your users will be stranded.

- [ ] **Evaluate Shorebird or CodePush**: Integrate a tool to push Dart code patches instantly to users without going through the app store review process.

## 5. Accessibility (a11y) & Text Scaling
Production apps must be usable by people with disabilities or those who use large system fonts.

- [ ] **Semantics Audit**: Ensure custom widgets (like `TaskCard`) have proper screen-reader labels.
- [ ] **Text Scaling Test**: Test the app with the system font size scaled up to 150% to ensure the UI doesn't overflow or break (use `TextOverflow.ellipsis` appropriately).

## 6. App Usage Analytics / Telemetry
While `AnalyticsBloc` provides user-facing insights, telemetry for product decisions is missing.

- [ ] **Integrate Firebase Analytics or PostHog**: Track which screens and features are actively used.
- [ ] **Opt-in Privacy Consent**: Since Reflect is privacy-focused, make telemetry explicitly "Opt-in" during onboarding.

## 7. Feature Flags / Remote Config
To safely rollout new features (e.g., Google Calendar Sync) and mitigate bugs without a new release.

- [ ] **Integrate Firebase Remote Config**: Allow enabling/disabling specific features or displaying a "Maintenance Mode" banner dynamically from a dashboard.

## 8. Legal & Store Requirements
Both Apple and Google have strict requirements for apps handling user data or authentication.

- [ ] **Hosted Privacy Policy**: Provide a publicly accessible Privacy Policy URL.
- [ ] **Delete Account Functionality**: Apple explicitly requires an in-app mechanism to permanently delete an account and associated data if account creation is supported.

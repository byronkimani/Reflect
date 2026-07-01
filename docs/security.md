# Security — Reflect

Security practices for secrets, local data, releases, and third-party integrations.

## Secrets and environment

- Never commit `.env.production`, keystores, or `firebase-credentials.json`.
- The app loads a single bundled env file: `env/active.env` (gitignored).
- Use `tool/prepare_env.sh <flavor>` before local runs/builds (`make run-dev`, `make build-prod-apk`).
- CI decodes production secrets only in the **deploy** job (push to `main`/`develop`), then deletes them in a cleanup step.

Required keys are documented in [`env/active.env.example`](../env/active.env.example).

Production builds (`--dart-define=ENV=production`) fail fast at startup when required keys are missing, use placeholder values (`replace_me`), or when `APP_ENV` is not `production`. See `ProductionEnvValidator`.

## Supply chain

- **Dependabot** (`.github/dependabot.yml`) opens weekly PRs for `pub` and GitHub Actions updates.
- **Local check:** `make deps-outdated` lists available updates; `make deps-check` fails when direct dependencies lag within pubspec constraints.
- **CI:** PR and push workflows run `make deps-check` after `flutter pub get` (see [Firebase App Distribution](../.github/workflows/firebase_distribution.yml)).

## Local database encryption

- Production SQLite uses **SQLCipher** via `sqlcipher_flutter_libs`.
- The encryption key is stored in `FlutterSecureStorage` (`DatabaseKeyService`).
- **First launch after this upgrade wipes existing local data** (fresh-start migration). Users lose tasks, reviews, and goals on that upgrade.

See also [`database.md`](database.md).

## Android backup

- `android:allowBackup="false"` with explicit backup/data-extraction exclude rules.
- Prevents ADB/cloud backup of database and preference files.

## Android network security

- `android/app/src/main/res/xml/network_security_config.xml` disables cleartext HTTP and trusts system CAs only.
- Referenced from `AndroidManifest.xml` via `android:networkSecurityConfig`.
- Verified manually on release APK builds (not unit-testable in Flutter).

## Auth tokens

- App auth tokens: `TokenStorage` → `FlutterSecureStorage` (v10).
- On Android, v10 uses Keystore-backed AES-GCM with a custom cipher implementation; the deprecated `encryptedSharedPreferences` option must **not** be re-enabled (removed in v10).
- On iOS, tokens use first-unlock keychain accessibility.
- Refresh is serialized (single in-flight refresh); invalid refresh responses clear tokens and emit `AuthSessionNotifier.expired`.

## HydratedBloc persistence (S6)

- `SettingsCubit` persists **non-sensitive** preferences only (theme, notification toggles, analytics opt-in).
- Never store auth tokens, refresh tokens, PII, or database keys in HydratedBloc storage.

## Application ID (S3 — pre-release blocker)

- The current Android application ID / iOS bundle identifier is still `com.example.reflect`.
- **Must be replaced** with the production app ID before Play Store submission or binding production Firebase API keys.
- Until then, treat store builds as internal/testing only.

## Google Calendar (planned)

- OAuth tokens will live in `GCalTokenStorage` (separate keys from app auth).
- Implementation must use OAuth 2.0 + PKCE, minimal scopes, and clear tokens on sign-out.
- See [`gcal-sync.md`](gcal-sync.md).

## Firebase

Before connecting a production backend:

1. Restrict Firebase API keys by app ID / bundle ID in Google Cloud Console.
2. Enable **Firebase App Check** before trusting client requests server-side.
3. Never embed admin SDK credentials in the mobile app.

## Observability

- **Crashlytics:** Global Flutter/async/BLoC errors are forwarded via `CrashReporter` (`FirebaseCrashReporter` in release; no-op in debug).
- **Product analytics:** Firebase Analytics via `AppAnalyticsService`, **opt-in only** (Settings → Usage analytics, default off). Events: `task_created`, `daily_review_submitted`, `planning_completed`.

## Release builds

- Production APK: `make build-prod-apk` (obfuscated, split debug info under `build/debug-info/`).
- Release signing requires CI keystore env vars; local `--release` without keystore uses debug signing (not for store upload).
- Upload debug symbols from CI artifacts for crash symbolication — do not ship them with the APK.

## Error handling

- Repositories use `FailureMapper` so internal exception text is not shown in UI snackbars.
- Detailed errors are logged only in debug mode (`kDebugMode`).

## Certificate pinning

Deferred. When added, pins will be env-gated and optional.

# Flutter Project Playbook

> **Purpose:** A personal reference to bootstrap any new Flutter project to the same quality bar as Reflect — clean architecture, tested, secured, CI-shipped, and AI-agent-ready.
>
> **Usage:** Copy this file to the root of a new project. Work through each section in order on day one. Sections marked **(Optional)** can be deferred.

---


## Table of Contents

0. [The Master Bootstrap Prompt](#0-the-master-bootstrap-prompt)
1. [AI Agent Initialization (AGENTS.md)](#1-ai-agent-initialization-agentsmd)
2. [Architectural Decisions & Planning](#2-architectural-decisions--planning)
3. [Project Scaffolding](#3-project-scaffolding)
4. [Dependency Stack](#4-dependency-stack)
5. [Clean Architecture Structure](#5-clean-architecture-structure)
6. [Code Generation Setup](#6-code-generation-setup)
7. [Dependency Injection Setup](#7-dependency-injection-setup)
8. [Environment & Secrets](#8-environment--secrets)
9. [Makefile (Developer Shortcuts)](#9-makefile-developer-shortcuts)
10. [Security Checklist](#10-security-checklist)
11. [Testing Conventions](#11-testing-conventions)
12. [CI / CD with GitHub Actions](#12-ci--cd-with-github-actions)
13. [Firebase Setup](#13-firebase-setup)
14. [Versioning Strategy](#14-versioning-strategy)
15. [Documentation Framework & Ways of Working](#15-documentation-framework--ways-of-working)
16. [Production Readiness Checklist](#16-production-readiness-checklist)

---

## 0. The Master Bootstrap Prompt

To completely bootstrap a production-ready app from zero, **simply copy the prompt below and paste it to your AI agent.** 

> **Goal:** I want to bootstrap a new Flutter application named `[Your App Name]`.
> 
> **Instructions:**
> Please read the `docs/flutter-project-playbook.md` file and execute the entire bootstrap process in chronological order (Sections 1 through 15). 
> 
> - **Stop at Section 2:** You must interview me on the key architectural decisions (State Management, Storage, Networking, Routing, UI) and **wait for my answers** before scaffolding anything.
> - **Execute completely:** Once we align on architecture, proceed through the rest of the playbook (Scaffold, Dependencies, Clean Architecture, CodeGen, Dependency Injection, Environments, Makefiles, Security, Testing, CI/CD, and Documentation). 
> - Generate all the exact boilerplate files, workflows, and markdown docs instructed in the playbook. 
> - **Security Check:** Ensure the agent explicitly configures `.gitignore` so that secrets (like `google-services.json`, `GoogleService-Info.plist`, and `firebase_options.dart`) are never committed by mistake.
> - **Firebase Walkthrough:** After bootstrapping is complete, provide me with a walkthrough of the manual Firebase setup steps from Section 13. Emphasize that Firebase App Distribution (App Tester) is the first product we will use, and remind/advise me to hide any secrets (e.g., the values in `firebase_options.dart`).
> 
> What are your architectural questions from Section 2?
---
## 1. AI Agent Initialization (AGENTS.md)

Create `AGENTS.md` at the project root. This file controls how AI coding assistants behave in the repository.

```markdown
# [App Name] — Agent Codex

> Read this file before writing or modifying any code.

## Hard Rules

1. **Tests ship with every change — no exceptions.** Every new or changed behavior must include tests before merge.
2. **No unauthorized commits.** Stage changes, show the diff, wait for approval.
3. **Tests are mandatory.** Every new/changed function ships with happy-path and failure/edge tests.
4. **No linter bypasses.** Never use `// ignore:` without explicit approval.
5. **No UI without a design reference.** Confirm direction before new layouts.
6. **Run codegen after model changes.** `@freezed`, `@JsonSerializable`, `@DriftDatabase` → run `make gen`.
7. **Follow Clean Architecture boundaries.** Presentation → Domain ← Data.
8. **Use BLoC/Cubit for state management.** Do not use `setState` or `ChangeNotifier`.
9. **No raw Material widgets for app-level patterns.** Use shared widgets from `core/presentation/`.
10. **Use typed routes.** Use GoRouter path constants.
11. **Use GetIt for DI.** Register dependencies in `core/di/injectors.dart`.
12. **No secrets in source.** Use `.env.*` files via `flutter_dotenv`.
13. **Preserve official app name.** Do not rename the app unless requested.
14. **Immutable models.** Use `@freezed` for all domain entities and state classes.
15. **Update docs on feature changes.** Update `docs/implementation-status.md`.
16. **Version bumping requires owner consent.** Always ask before touching the version string.
17. **Release notes required.** Document changes for testers when shipping a new release.
18. **Keep documentation synced.** Always keep all documentation updated as code changes are made. Any conflicts or discrepancies must be raised to the user. The playbook itself must be kept up to date with any newly introduced coding guidelines.
19. **Ask architectural questions.** When bootstrapping a new project or feature, do not assume default technologies. Ask the user architectural questions (e.g., State Management, Storage, Networking) to determine the right stack if it isn't explicitly specified.

## Pre-flight (before writing code)

- [ ] Read the Hard Rules above.
- [ ] Check `docs/implementation-status.md`.
- [ ] If adding UI: confirm a design reference exists.
- [ ] If changing a model: prepare to run `make gen`.

## Post-flight (before handing back)

- [ ] `make lint` — zero errors.
- [ ] `make test` — all tests pass.
- [ ] Clean Architecture boundaries intact.
- [ ] No unauthorized `git commit`.
- [ ] Ask for version bump approval if a feature was added/changed.

## Architecture

**Framework:** Flutter
**State:** BLoC/Cubit
**DI:** GetIt
**Routing:** GoRouter
**DB:** Drift (SQLite)

## Environment

| Command | Env |
|---------|-----|
| `make run-dev` | `.env.testing` |
| `make run-prod` | `.env.production` |

Never commit `.env.production`.
```

---

## 2. Architectural Decisions & Planning

Every project is different. Before running any commands or writing code, **always** confirm the architectural stack with the developer. Do not blindly assume the Reflect stack (BLoC + Drift) for every new project.

If the developer has not provided an explicit stack, **ask them architectural questions** (or suggest they use the `/grill-me` command) to resolve the following decisions:

1. **State Management:** BLoC/Cubit, Riverpod, Provider, or simply `ValueNotifier`?
2. **Local Storage:** Drift (relational, heavy), Hive/Isar (NoSQL, fast), or just `SharedPreferences`?
3. **Networking & API:** REST via `dio`, GraphQL, or Firebase backend?
4. **Routing:** `go_router` (complex deep links) or standard `Navigator 2.0` / auto_route?
5. **UI / Styling:** Custom design system, standard Material 3, or a UI kit?

Once these decisions are finalized, document them in `ARCHITECTURE.md` and proceed with the scaffolding below using the agreed-upon stack.

---

## 3. Project Scaffolding

```bash
# Create the project
flutter create my_app --org com.yourname --platforms android,ios

cd my_app

# Initialise git immediately
git init
git add .
git commit -m "chore: initial Flutter scaffold"
```

### `.gitignore` — add these project-specific entries

```
# Secrets & env
.env.*
!.env.example
env/active.env
firebase-credentials.json
android/app/upload-keystore.jks
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
lib/firebase_options.dart

# Generated code
*.g.dart
*.freezed.dart

# Coverage
coverage/

# Build artifacts
build/
```

### Recommended `analysis_options.yaml`

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - always_declare_return_types
    - avoid_print
    - prefer_const_constructors
    - prefer_const_declarations
    - unawaited_futures
```

---

## 4. Dependency Stack

Below are the packages that have proven reliable. Pick the ones that fit your project — nothing here is mandatory except what your architecture requires.

### Core (`pubspec.yaml` → `dependencies`)

| Package | Purpose | Alternatives |
|---------|---------|--------------|
| `flutter_bloc` | State management (BLoC/Cubit) | `riverpod`, `provider` |
| `get_it` | Dependency injection | `riverpod` providers |
| `go_router` | Declarative, typed routing | `auto_route` |
| `freezed_annotation` | Immutable models & sealed unions | `dart_mappable` |
| `json_annotation` | JSON serialisation | built into `dart_mappable` |
| `drift` | Type-safe SQLite ORM | `floor`, `sqflite` |
| `flutter_dotenv` | Env file loading | `envied` |
| `fpdart` | Functional: `Either`, `Option` | plain exceptions |
| `hydrated_bloc` | Persisted BLoC state | manual `SharedPreferences` |
| `flutter_secure_storage` | Secure key storage (tokens, DB key) | — |
| `path_provider` | Platform file paths | — |
| `path` | Path string utilities | — |
| `dio` | HTTP client with interceptors | `http` |
| `firebase_core` | Firebase base | — |
| `firebase_analytics` | Product telemetry (opt-in) | PostHog |
| `firebase_crashlytics` | Crash reporting | Sentry |
| `flutter_local_notifications` | Local push notifications | — |
| `intl` / `flutter_localizations` | Internationalisation | — |

### (Optional) SQLCipher Encryption

If the app stores sensitive personal data locally, add:

```yaml
sqlcipher_flutter_libs: ^0.6.8   # Encrypted SQLite
sqlite3: ^3.2.0                   # Required companion
```

See [Section 7 — Security](#7-security-checklist) for wiring instructions.

### Dev / Test (`dev_dependencies`)

```yaml
build_runner: ^2.4.0
freezed: ^2.5.0
json_serializable: ^6.8.0
drift_dev: ^2.20.2
flutter_test:
  sdk: flutter
bloc_test: ^9.1.0
mocktail: ^1.0.0
```

---

## 5. Clean Architecture Structure

Every feature lives in `lib/features/<feature_name>/` and is broken into three layers. Imports only flow **inward** — presentation → domain ← data.

```
lib/
├── core/
│   ├── di/                   # GetIt service locator
│   │   └── injectors.dart
│   ├── error/                # Failure types & FailureMapper
│   ├── network/              # Dio client, interceptors
│   ├── presentation/         # Shared widgets (AppScaffold, etc.)
│   ├── routing/              # GoRouter setup & path constants
│   └── storage/
│       └── database/         # AppDatabase (Drift), migrations
│
└── features/
    └── tasks/
        ├── data/
        │   ├── datasources/  # Remote & local data sources
        │   ├── models/       # JSON/DB models with @JsonSerializable
        │   └── repositories/ # Implements domain interfaces
        ├── domain/
        │   ├── entities/     # @freezed domain models (no Flutter imports)
        │   ├── repositories/ # Abstract interfaces (ITaskRepository)
        │   └── usecases/     # Single-responsibility use cases (optional)
        └── presentation/
            ├── blocs/        # BLoC / Cubit state management
            ├── pages/        # Full-screen routes
            └── widgets/      # Feature-specific widgets
```

### Hard Architecture Rules

- **Presentation** must never import from `data/`.
- **Domain** must never import Flutter SDK or `data/`.
- **Data** implements domain interfaces — dependency inversion.
- All domain entities and BLoC states use `@freezed` — never mutable models.

---

## 6. Code Generation Setup

Three annotations drive codegen: `@freezed` (models), `@JsonSerializable` (JSON), `@DriftDatabase` (SQLite).

```bash
# One-time build
dart run build_runner build --delete-conflicting-outputs

# Watch mode during development
dart run build_runner watch --delete-conflicting-outputs
```

> **Rule:** Any time you add/modify a `@freezed`, `@JsonSerializable`, or `@DriftDatabase` annotated file, run `make gen` before continuing. Never commit `.g.dart` or `.freezed.dart` files without regenerating.

---

## 7. Dependency Injection Setup

We use `get_it` as our service locator. The AI agent must automatically scaffold this pattern.

1. Create `lib/core/di/injectors.dart`.
2. Add a `setupDependencies()` function.
3. Call `setupDependencies()` in `main.dart` before `runApp()`.

**Pattern:**
- `registerLazySingleton`: For Repositories, Services, and Databases.
- `registerFactory`: For BLoCs/Cubits (to ensure fresh state on navigation).

```dart
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // e.g. getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
}
```

---

## 8. Environment & Secrets

### Directory layout

```
env/
├── active.env          # gitignored — copied by prepare_env.sh
└── active.env.example  # committed — documents all required keys

.env.testing            # gitignored — testing values
.env.production         # gitignored — NEVER commit this
```

### `env/active.env.example`

```
API_BASE_URL=https://api.example.com
SOME_API_KEY=your_key_here
```

### `tool/prepare_env.sh`

```bash
#!/bin/bash
set -e
FLAVOR=${1:-testing}
echo "[env] Loading .env.$FLAVOR"
cp ".env.$FLAVOR" env/active.env
```

```bash
chmod +x tool/prepare_env.sh
```

### Loading in Dart (`lib/core/config/env_config.dart`)

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static Future<void> init() async {
    await dotenv.load(fileName: 'env/active.env');
  }

  static String get apiBaseUrl => dotenv.env['API_BASE_URL']!;
}
```

### `main.dart`

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfig.init();
  runApp(const MyApp());
}
```

---

## 9. Makefile (Developer Shortcuts)

Copy this `Makefile` to the project root. Replaces long commands with memorable shortcuts.

```makefile
.PHONY: gen test clean get lint run-dev run-prod watch coverage format fix build-prod-apk

gen:
	dart run build_runner build --delete-conflicting-outputs

watch:
	dart run build_runner watch --delete-conflicting-outputs

test: prepare-env-testing
	flutter test

coverage: prepare-env-testing
	flutter test --coverage
	lcov --remove coverage/lcov.info '*.g.dart' '*.freezed.dart' '*/tables/*' '*firebase_options.dart' '*/di/*' '*/l10n/*' '*app_theme.dart' '*/main.dart' -o coverage/lcov.info --ignore-errors unused
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html

lint:
	flutter analyze --fatal-infos --fatal-warnings

fix:
	dart fix --apply

format:
	dart format .

clean:
	flutter clean
	flutter pub get

get:
	flutter pub get

deps-outdated:
	dart pub outdated

deps-upgrade:
	dart pub upgrade

deps-check:
	dart run tool/check_outdated_deps.dart

prepare-env-testing:
	chmod +x tool/prepare_env.sh
	./tool/prepare_env.sh testing

prepare-env-production:
	chmod +x tool/prepare_env.sh
	./tool/prepare_env.sh production

run: run-dev

run-dev: prepare-env-testing
	flutter run --dart-define=ENV=testing

run-prod: prepare-env-production
	flutter run --dart-define=ENV=production

build-prod-apk: prepare-env-production
	flutter build apk --release \
		--obfuscate \
		--split-debug-info=build/debug-info \
		--dart-define=ENV=production
```

---

## 10. Security Checklist

### Secrets

- [ ] All secrets loaded via `flutter_dotenv` — never hardcoded.
- [ ] `.env.production` and keystores are gitignored.
- [ ] CI decodes secrets from base64-encoded GitHub Secrets, then deletes them at end of job.

### Android Manifest

```xml
<application
  android:allowBackup="false"
  android:fullBackupContent="false"
  ...>
```

This prevents Android cloud/ADB backups from leaking the local database.

### Release Build

Always build with obfuscation to prevent reverse engineering:

```bash
flutter build apk --release \
  --obfuscate \
  --split-debug-info=build/debug-info
```

Upload the `build/debug-info/` folder as a CI artifact for crash symbolication.

### Tokens & Auth

- Store auth tokens in `flutter_secure_storage` (uses Keychain on iOS, EncryptedSharedPreferences on Android).
- Single in-flight refresh pattern — avoid parallel token refresh races.
- Clear all tokens on sign-out.

### (Optional) SQLCipher — Local Database Encryption

If the app stores sensitive personal data locally:

1. Add `sqlcipher_flutter_libs` and `sqlite3` to `pubspec.yaml`.
2. Create a `DatabaseKeyService` that generates a 256-bit key on first launch and stores it in `flutter_secure_storage`.
3. Open the Drift database with the key:

```dart
NativeDatabase.createInBackground(
  file,
  setup: (rawDb) {
    rawDb.execute("PRAGMA key = '$key';");
  },
);
```

> **Warning:** Adding encryption to an existing app requires a fresh-start migration (wipe existing unencrypted database). Plan this before initial release.

### Firebase

- Restrict API keys by app bundle ID in Google Cloud Console.
- Enable Firebase App Check before trusting any client requests server-side.
- Never embed Firebase Admin SDK credentials in the mobile app.

---

## 11. Testing Conventions

### Philosophy

- Testing is **mandatory**, not optional.
- Every new or changed function ships with at least one happy-path test **and** one failure/edge test.
- Never use `// ignore:` to bypass linter warnings in tests.

### Test Layout

```
test/
├── core/
│   └── network/
│       └── auth_interceptor_test.dart
└── features/
    └── tasks/
        ├── data/
        │   └── repositories/
        │       └── task_repository_impl_test.dart
        ├── domain/
        │   └── (entity / use case tests)
        └── presentation/
            ├── blocs/
            │   └── task_list_bloc_test.dart
            └── pages/
                └── today_page_test.dart
```

### Unit Tests (domain & data)

```dart
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockTaskRepository extends Mock implements ITaskRepository {}

void main() {
  late MockTaskRepository repository;

  setUp(() {
    repository = MockTaskRepository();
  });

  test('returns failure when repository throws', () async {
    when(() => repository.getTasks()).thenThrow(Exception('DB error'));
    // ...
  });
}
```

### BLoC Tests

```dart
import 'package:bloc_test/bloc_test.dart';

blocTest<TaskListBloc, TaskListState>(
  'emits [loading, loaded] on success',
  build: () {
    when(() => mockRepo.getTasks()).thenAnswer((_) async => right([]));
    return TaskListBloc(mockRepo);
  },
  act: (bloc) => bloc.add(const LoadTasks()),
  expect: () => [
    const TaskListState.loading(),
    const TaskListState.loaded(tasks: []),
  ],
);
```

> **Note:** If your BLoC uses `compute()` for background processing, the Flutter test runner's synthetic clock can cause race conditions. Detect the test environment and fall back to synchronous execution:
> ```dart
> bool get _isTestEnv => !kIsWeb && Platform.environment.containsKey('FLUTTER_TEST');
> ```

### Drift (Database) Tests — use in-memory SQLite

```dart
import 'package:drift/native.dart';

AppDatabase createTestDatabase() {
  return AppDatabase.forTesting(NativeDatabase.memory());
}
```

### Coverage Threshold

- Target: **≥ 98%** overall (enforced in CI).
- Exclude generated files: `*.g.dart`, `*.freezed.dart`, `*/tables/*`, `*firebase_options.dart`, `*/di/*`, `*/l10n/*`, `*app_theme.dart`, `*/main.dart`.

---

## 12. CI / CD with GitHub Actions

### Workflow structure

Create `.github/workflows/firebase_distribution.yml`. The workflow has two jobs:

1. **test** — runs on every push and PR.
2. **deploy** — runs only on push to `main`/`develop` after tests pass.

```yaml
name: Firebase App Distribution

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

jobs:
  test:
    name: Test & Coverage
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.44.4'   # pin exact version
          channel: 'stable'
          cache: true

      - name: Prepare Testing Environment
        run: |
          chmod +x tool/prepare_env.sh
          ./tool/prepare_env.sh testing

      - run: flutter pub get
      - run: sudo apt-get install -y lcov
      - run: flutter test --coverage

      - name: Filter Generated Files from Coverage
        run: |
          lcov --remove coverage/lcov.info '*.g.dart' '*.freezed.dart' '*/tables/*' '*firebase_options.dart' '*/di/*' '*/l10n/*' '*app_theme.dart' '*/main.dart' -o coverage/lcov.info --ignore-errors unused

      - name: Check Coverage Threshold (98%)
        uses: VeryGoodOpenSource/very_good_coverage@v3
        with:
          path: coverage/lcov.info
          min_coverage: 98

      - uses: actions/upload-artifact@v4
        with:
          name: coverage-html-report
          path: coverage/html/

  deploy:
    name: Build & Distribute APK
    if: github.event_name == 'push'
    runs-on: ubuntu-latest
    needs: test
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          distribution: 'zulu'
          java-version: '17'
      - uses: gradle/actions/setup-gradle@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.44.4'
          channel: 'stable'
          cache: true

      - name: Decode Secrets
        run: |
          echo "${{ secrets.ENV_PRODUCTION_BASE64 }}" | base64 --decode > .env.production
          echo "${{ secrets.KEYSTORE_BASE64 }}"       | base64 --decode > android/app/upload-keystore.jks
          echo "${{ secrets.FIREBASE_CREDENTIALS_BASE64 }}" | base64 --decode > firebase-credentials.json
          chmod +x tool/prepare_env.sh
          ./tool/prepare_env.sh production

      - run: flutter pub get

      - name: Build Release APK
        env:
          KEYSTORE_PASSWORD: ${{ secrets.KEYSTORE_PASSWORD }}
          KEY_ALIAS: ${{ secrets.KEY_ALIAS }}
          KEY_PASSWORD: ${{ secrets.KEY_PASSWORD }}
        run: |
          flutter build apk --release \
            --obfuscate \
            --split-debug-info=build/debug-info \
            --dart-define=ENV=production \
            --build-number=${{ github.run_number }}

      - uses: actions/upload-artifact@v4
        with:
          name: debug-symbols
          path: build/debug-info/

      - name: Upload to Firebase App Distribution
        uses: nickwph/firebase-app-distribution-action@v1
        with:
          app: ${{ secrets.FIREBASE_APP_ID }}
          credentials-file: firebase-credentials.json
          groups: qa-team
          file: build/app/outputs/flutter-apk/app-release.apk

      - name: Cleanup Secrets
        if: always()
        run: |
          rm -f .env.production env/active.env android/app/upload-keystore.jks firebase-credentials.json
```

### GitHub Secrets to configure

| Secret name | What it contains |
|-------------|-----------------|
| `ENV_PRODUCTION_BASE64` | `base64 -i .env.production` |
| `KEYSTORE_BASE64` | `base64 -i upload-keystore.jks` |
| `KEYSTORE_PASSWORD` | Keystore password |
| `KEY_ALIAS` | Key alias |
| `KEY_PASSWORD` | Key password |
| `FIREBASE_CREDENTIALS_BASE64` | `base64 -i firebase-credentials.json` |
| `FIREBASE_APP_ID` | Firebase App ID (from console) |

---

## 13. Firebase Setup

### 10.1 Firebase App Distribution (Beta delivery to testers)

**One-time setup:**

1. Create a project in [Firebase Console](https://console.firebase.google.com).
2. Add an Android app — use the bundle ID from `pubspec.yaml` / `build.gradle`.
3. Download `google-services.json` → place in `android/app/` (gitignored).
4. In **App Distribution → Groups**, create a `qa-team` group and add tester emails.
5. Download a **Service Account** JSON for CI. The service account needs the **Firebase App Distribution Admin** role in Google Cloud IAM.

**Inviting a tester (first time):**

1. Firebase Console → App Distribution → Testers & Groups.
2. Add the tester's email. Firebase sends them an invitation email.
3. Tester clicks the link → installs the **Firebase App Tester** app.
4. Tester opens Firebase App Tester → signs in → sees all releases.

**Installing a build (tester flow):**

1. Tester receives an email when CI uploads a new build.
2. Tap "Download latest" in the email or inside the App Tester app.
3. **Android:** Allow installation from unknown sources when prompted (one-time).
4. **iOS:** Trust the distribution certificate: *Settings → General → VPN & Device Management → [developer name] → Trust*.

### 10.2 Firebase Crashlytics (Crash Reporting)

```yaml
firebase_crashlytics: ^4.0.0
```

**`main.dart` wiring:**

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Catch Flutter framework errors
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Catch async / platform errors
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}
```

**Reading crash reports:**

- Firebase Console → Crashlytics → **Issues** tab.
- Each crash shows: device, OS, app version, full symbolicated stack trace.
- Upload debug symbols from CI (`build/debug-info/`) for deobfuscated traces.

### 10.3 Firebase Analytics (Opt-in Product Telemetry)

```yaml
firebase_analytics: ^11.0.0
```

- Disable collection by default; enable only after the user explicitly opts in.
- Log custom events for key flows: feature used, core action completed.
- View data in Firebase Console → Analytics → **Events**.

---

## 14. Versioning Strategy

### Format: `MAJOR.MINOR.PATCH+BUILD`

| Segment | When to bump |
|---------|-------------|
| `MAJOR` | Massive architectural overhaul or complete UX redesign |
| `MINOR` | New user-facing feature added |
| `PATCH` | Bug fix or internal improvement (no new features) |
| `BUILD` | Every single APK — auto-injected by CI (`github.run_number`) |

### Rules

- **Never bump the version without owner consent** — always ask first.
- The `+BUILD` in `pubspec.yaml` is a placeholder; CI always injects `github.run_number`.
- Always include **release notes** when shipping to testers.

### `pubspec.yaml` example

```yaml
version: 1.2.0+1     # MAJOR.MINOR.PATCH+BUILD (BUILD is a placeholder)
```

---

## 15. Documentation Framework & Ways of Working

The AI agent must generate a full `docs/` directory upon bootstrap. We follow a **Continuous Documenting Process** where documentation and spec are updated alongside every feature.

### Base Files to Generate at Bootstrap:

1. **`README.md` (root)** — App overview, architecture summary, and setup/run instructions.
2. **`ARCHITECTURE.md` (root)** — Layer diagram (Clean Architecture), boundaries, and the tech stack agreed upon in Section 2.
3. **`docs/README.md`** — A central index linking to all other docs.
4. **`docs/agent-map.md`** — A mental map/index to help AI agents quickly look up where domain models, screens, and configs live without searching.
5. **`docs/implementation-status.md`** — A strict tracker of features marked as `Shipped`, `In-Progress`, or `Planned`.
6. **`docs/collaboration-framework.md`** — Rules governing the AI-User brainstorm process (e.g. "No code before spec", "Offline-first alignment").
7. **`docs/di.md`** — Documentation on how `get_it` is structured in the app.
8. **`docs/state-management.md`, `docs/database.md`, `docs/routing.md`** — Brief summaries of conventions for each domain based on Section 2's answers.

### Continuous Documenting Process (Agent Rule)

- The agent must operate in a **Spec-First** manner. Code is not written until a markdown spec is reviewed.
- Whenever the agent adds a new feature or alters a database schema, it **must proactively update all related documents** (especially `implementation-status.md` and `ARCHITECTURE.md`).

---

## 16. Production Readiness Checklist

Use this before submitting to the App Store or Google Play.

### Core Quality

- [ ] All tests pass (`make test`)
- [ ] Lint is clean (`make lint`)
- [ ] Code coverage ≥ 98%
- [ ] No hardcoded secrets — all via `flutter_dotenv`
- [ ] Release APK built with `--obfuscate --split-debug-info`
- [ ] Debug symbols uploaded as CI artifact

### Crash Reporting & Observability

- [ ] Firebase Crashlytics integrated
- [ ] `FlutterError.onError` wired to Crashlytics
- [ ] `PlatformDispatcher.instance.onError` wired to Crashlytics
- [ ] Verified crash appears in Firebase Console (test in debug mode)

### Security

- [ ] `android:allowBackup="false"` in `AndroidManifest.xml`
- [ ] Auth tokens in `flutter_secure_storage`
- [ ] Firebase API keys restricted by bundle ID in Google Cloud Console
- [ ] Firebase App Check enabled (if using Firebase backend services)

### Accessibility

- [ ] Custom widgets have `Semantics` labels for screen readers
- [ ] UI tested at 150% system font size — no overflows

### Legal / Store Requirements

- [ ] Privacy Policy URL published and linked in store listing
- [ ] "Delete Account" flow exists in-app (required by Apple)
- [ ] App store screenshots and description ready

### (Optional) Advanced

- [ ] Firebase Remote Config for feature flags
- [ ] OTA update strategy evaluated (Shorebird)
- [ ] Data export / manual backup for users
- [ ] `RestorationMixin` on critical forms

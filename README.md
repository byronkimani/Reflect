# Reflect

Reflect is a powerful, offline-first personal task manager and wellness tool designed for high-agency individuals who value privacy and focus. It combines daily planning, deep reflection, and advanced task recurrence into a single, cohesive experience.

## Read This In Order

| Need | Start here |
| --- | --- |
| Set up the repo, run scripts, or understand local env | [`README.md`](README.md) |
| Understand repo structure, routing, and system boundaries | [`ARCHITECTURE.md`](ARCHITECTURE.md) |
| Get a structure-first map of the application source tree | [`lib/README.md`](lib/README.md) |
| Follow durable coding rules and guardrails | [`AGENTS.md`](AGENTS.md) |
| Find the source-of-truth spec for a feature | [`docs/README.md`](docs/README.md) |
| Check what is shipped, placeholder, or deferred | [`docs/implementation-status.md`](docs/implementation-status.md) |
| Jump from a task area to the right docs, code, and tests | [`docs/agent-map.md`](docs/agent-map.md) |

## Tech stack

| Layer | Technology |
| --- | --- |
| Framework | Flutter SDK `^3.44.4` (Targeting Android & iOS) |
| Language | Dart `^3.12.2` |
| UI & Routing | Material Design, GoRouter `^17.0.0` |
| State Management | BLoC / Cubit `^9.1.1`, HydratedBloc `^11.0.0` |
| Dependency Injection | GetIt `^9.1.1` |
| Database | Drift (SQLite) `^2.20.2` |
| Data Modeling | Freezed `^3.2.3`, JSON Serializable `^6.11.2` |
| API / Networking | Dio `^5.5.0` |

## Architecture

The project follows a **Feature-Driven Clean Architecture**, ensuring high modularity and testability.

```text
UI (Widgets) ← BLoC / Cubit (State) ← Domain (Use Cases/Repos) ← Data (Drift / API)
```

Reflect is strictly offline-first. Your data is stored locally via `drift` on your device, with optional background sync to Google Calendar. 

## Getting started

### Prerequisites

- **Flutter SDK** installed (`flutter doctor` should be green).
- **Android Studio** for Android builds.
- **Xcode** & **CocoaPods** for iOS builds.

### Setup

```bash
git clone https://github.com/byronkimani/reflect.git
cd reflect
flutter pub get
```

### Local Configuration & Artifacts

To run the application locally or build it, you must acquire the following artifacts and configuration files from the team lead or password manager, as they contain sensitive secrets and are not checked into source control:

1. **Environment Variables (`.env` files)**:
   Create `.env.testing` and `.env.production` in the project root. These contain API keys and external service URLs.
   > **Note**: Never commit these files. They are already added to `.gitignore`.

2. **Firebase Configuration**:
   - **Android**: Place `google-services.json` in `android/app/`.
   - **iOS**: Place `GoogleService-Info.plist` in `ios/Runner/`.

3. **Android Keystores (For Release Builds)**:
   - Place the upload keystore (`upload-keystore.jks`) in the `android/app/` directory.
   - Obtain the `key.properties` file and place it in `android/` containing the store password, key password, and aliases.

### Environment modes

Reflect supports different environment modes through dart defines:

| Mode | Command | Description |
| --- | --- | --- |
| Testing (Default) | `make run-dev` | Uses `.env.testing` |
| Production | `make run-prod` | Uses `.env.production` |

## Scripts

Reflect uses a `Makefile` for common tasks:

```bash
make run              # Start Flutter dev server (testing flavor)
make run-prod         # Start Flutter dev server (production flavor)
make gen              # Run build_runner to generate Drift/Freezed code
make watch            # Watch for changes and re-generate code
make test             # Run all unit and widget tests
make coverage         # Generate coverage report
make lint             # Static analysis (zero issues required)
make fix              # Apply dart fix automatically
make format           # Format dart code
make clean            # flutter clean && flutter pub get
make deps-outdated    # List available package updates
make deps-upgrade     # Upgrade packages within pubspec constraints
make deps-check       # Fail if direct deps are behind upgradable versions
```

**CRITICAL**: You must run `make gen` after changing any files annotated with `@freezed`, `@JsonSerializable`, `@DriftDatabase`, or `@DriftAccessor`.

## Testing

Testing is mandatory. We require unit and widget tests for presentation, and integration tests for core flows. 
See the full policy in [`docs/testing.md`](docs/testing.md).

Run the test suite using:
```bash
make test
```

## Installing Pre-Release Builds (App Testers)

If you have been invited to test Reflect via Firebase App Distribution, follow these steps to install the app on your Android device:

1. **Accept the Invite**: Open the invitation email from Firebase on your Android device and tap **Get Started** or **Accept Invitation**.
2. **Sign In**: Sign in with your Google account when prompted.
3. **Install Firebase App Tester**: You will be prompted to download the **Firebase App Tester** app. Download and install it. *(Note: You may need to allow your browser to "Install unknown apps" in Android Settings).*
4. **Install Reflect**: Open the App Tester app, select **Reflect** from your available apps, and tap **Download** / **Install**.
5. **Updates**: Whenever a new version is released, you will receive an email and can update directly through the App Tester app.

## Contributing

We follow a GitFlow-lite model (`main` → `develop` → feature branches). See [`CONTRIBUTING.md`](CONTRIBUTING.md) for full branch strategies, PR templates, and coding standards.

***

*Built with ❤️ for focused minds.*

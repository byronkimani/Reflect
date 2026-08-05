## Hard Rules (check before every task)

> All rules below are non-negotiable. Scan this list before writing any code.

1. **Tests ship with every change — no exceptions.** Every new or changed behavior must include tests before merge: at minimum one **happy-path** and one **failure/edge** test. **Unit** tests for domain/data/core, **widget** tests for presentation UI, **bloc_test** for BLoC/Cubit. Filtered coverage from `make coverage` must stay **≥ 99%** in CI (same exclusions as CI).
2. **No unauthorized commits.** Stage all changes, show the diff to the user, and wait for explicit approval before running `git commit`.
3. **Tests are mandatory, not optional.** (See rule 1.) Every changed or new function ships with at least one happy-path test **and** at least one failure/edge test. Unit, widget, and integration tests are required based on the layer changed.
4. **No linter bypasses.** Never bypass the linter using `// ignore: ...` unless explicitly specified by the user. `make lint` must exit with **zero** analyzer issues (errors, warnings, and info).
5. **No UI without a design reference.** Do not invent new UI layouts or visual treatments unless the user provides an explicit Figma reference or approved direction. Written design specs in `docs/design/` are not maintained (pending a future redesign); use existing theme/widgets in `lib/core/presentation/` for consistency until new specs exist.
6. **Run codegen after model changes.** Any change to `@freezed`, `@JsonSerializable`, or `@DriftDatabase`/`@DriftAccessor` annotated files requires running `make gen` before continuing.
7. **Follow Clean Architecture boundaries.** Presentation layer must not import `data/` directly. Domain layer must not import Flutter or `data/`. Data layer implements domain interfaces.
8. **Use BLoC/Cubit for state management.** Do not use `setState`, `ChangeNotifier`, or other state management in feature code.
9. **No raw Material widgets for app-level patterns.** Use the app's shared widgets from `core/presentation/` (e.g., `AppScaffold`, `ConnectivityWrapper`) rather than bare `Scaffold` or `MaterialApp`.
10. **Use typed routes.** Use GoRouter path constants — do not hardcode route strings.
11. **Use GetIt for DI.** Register dependencies in `core/di/injectors.dart`. Do not use manual constructor injection at the widget level.
12. **No secrets in source.** Use `.env.*` files via `flutter_dotenv`. Never commit `.env.production`.
13. **Preserve official app name.** The product name is **Reflect**. Do not rename it in metadata, docs, or UI unless explicitly requested.
14. **Immutable models.** Use `@freezed` for all domain entities and state classes. Do not create mutable model classes.
15. **Update docs on code changes.** When adding or removing features, update `docs/implementation-status.md` and related documentation.
16. **Version bumping.** When a new feature is added or a bug is fixed, you MUST ask the user for explicit consent before bumping the `MAJOR.MINOR.PATCH` version string in `pubspec.yaml`. Read `docs/versioning.md` for guidelines.
17. **Release Notes.** When sending out a new feature, ensure that release notes are created/updated to document the changes for users and testers.
18. **Keep documentation synced.** Always keep all documentation updated as code changes are made. Any conflicts or discrepancies must be raised to the user. For instance, the `flutter-project-playbook.md` needs to be updated as new coding guidelines are introduced so it always reflects the latest standards.
19. **Ask architectural questions.** When bootstrapping a new project or feature, do not assume default technologies. Ask the user architectural questions (e.g., State Management, Storage, Networking) to determine the right stack if it isn't explicitly specified.
20. **Respect safe areas consistently.** Use `ReflectStickyBottomBar` for full-screen sticky CTAs, `ReflectTabPageSafeArea` + `reflect_page_insets.dart` helpers for tab-root pages, and `SafeArea` (plus keyboard `viewInsets` padding) on modal bottom sheets. Do not hardcode status-bar offsets or pin primary actions flush to the screen bottom.
---

# Reflect — Agent Codex

> Canonical reference for AI coding assistants working in this repository.  
> Read this file **before** writing or modifying any code.

> **Which file should you read next?**
> - Need repo structure or boundaries? Read [`ARCHITECTURE.md`](ARCHITECTURE.md).
> - Need a source tree layout? Read [`lib/README.md`](lib/README.md).
> - Need a feature spec? Read [`docs/README.md`](docs/README.md).
> - Need shipped vs deferred status? Read [`docs/implementation-status.md`](docs/implementation-status.md).
> - Need the fastest task-to-file lookup? Read [`docs/agent-map.md`](docs/agent-map.md).

---

## Agent pre-flight and post-flight

### Before writing any code (pre-flight)

- [ ] Read the Hard Rules above. Note which ones apply to this task.
- [ ] Open the feature spec in `docs/` for the area being changed.
- [ ] Check `docs/implementation-status.md` — is this shipped, in-progress, or planned?
- [ ] If adding or changing UI: confirm a design reference exists.
- [ ] If changing a model: prepare to run `make gen`.

### Before handing back to the user (post-flight)

- [ ] Run `make lint` — **zero** analyzer issues (errors, warnings, and info; no bypasses).
- [ ] Run `make test` — all tests pass.
- [ ] Every changed or new function has at least one failure/edge test.
- [ ] Clean Architecture boundaries are intact.
- [ ] No unauthorized `git commit` was created.
- [ ] If this task adds or changes a feature, ask the user for permission to bump the version string in `pubspec.yaml`.

---

## 1. Project Overview

**Product:** **Reflect** — an offline-first personal task manager and wellness tool. Focuses on privacy, daily planning, and advanced recurrence.

**Framework:** Flutter (Targeting Android and iOS)

**Architecture:** Feature-Driven Clean Architecture. UI uses BLoC/Cubit for state management, interacting with Domain Use Cases/Repositories, which are implemented by Data layer connected to Drift (SQLite).

## 2. Environment Configuration

| Variable/Mode | Purpose |
|----------|---------|
| `make run-dev` | Uses `.env.testing` (Default for local development) |
| `make run-prod` | Uses `.env.production` (Production build) |

**Git branches:** PRs target **`develop`** (default). Promote to **`main`** via PR only. No direct pushes to either. CI distributes merged builds to App Tester — see [`docs/deployment.md`](docs/deployment.md).

Never commit `.env.production`. Use `flutter_dotenv` to load these values securely.

## 3. Testing Policy

- **Unit Tests:** `test/core/` and `test/features/*/domain` or `data` layers.
- **Widget Tests:** `test/features/*/presentation/` using `bloc_test` and `mocktail`.
- **Integration Tests:** (Coming soon) For full end-to-end flows like daily planning or Google Calendar sync.

Read the full testing policy in [`docs/testing.md`](docs/testing.md).

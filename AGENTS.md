## Hard Rules (check before every task)

> All rules below are non-negotiable. Scan this list before writing any code.

1. **No unauthorized commits.** Stage all changes, show the diff to the user, and wait for explicit approval before running `git commit`.
2. **Tests are mandatory, not optional.** Every changed or new function ships with at least one happy-path test **and** at least one failure/edge test. Unit, widget, and integration tests are required based on the layer changed.
3. **No linter bypasses.** Never bypass the linter using `// ignore: ...` unless explicitly specified by the user.
4. **No UI without a design reference.** Do not invent new UI layouts or visual treatments unless the user has provided an explicit Figma reference or an approved direction.
5. **Run codegen after model changes.** Any change to `@freezed`, `@JsonSerializable`, or `@DriftDatabase`/`@DriftAccessor` annotated files requires running `make gen` before continuing.
6. **Follow Clean Architecture boundaries.** Presentation layer must not import `data/` directly. Domain layer must not import Flutter or `data/`. Data layer implements domain interfaces.
7. **Use BLoC/Cubit for state management.** Do not use `setState`, `ChangeNotifier`, or other state management in feature code.
8. **No raw Material widgets for app-level patterns.** Use the app's shared widgets from `core/presentation/` (e.g., `AppScaffold`, `ConnectivityWrapper`) rather than bare `Scaffold` or `MaterialApp`.
9. **Use typed routes.** Use GoRouter path constants — do not hardcode route strings.
10. **Use GetIt for DI.** Register dependencies in `core/di/injectors.dart`. Do not use manual constructor injection at the widget level.
11. **No secrets in source.** Use `.env.*` files via `flutter_dotenv`. Never commit `.env.production`.
12. **Preserve official app name.** The product name is **Reflect**. Do not rename it in metadata, docs, or UI unless explicitly requested.
13. **Immutable models.** Use `@freezed` for all domain entities and state classes. Do not create mutable model classes.
14. **Update docs on code changes.** When adding or removing features, update `docs/implementation-status.md` and related documentation.

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

- [ ] Run `make lint` — fix all errors and warnings (without bypassing rules).
- [ ] Run `make test` — all tests pass.
- [ ] Every changed or new function has at least one failure/edge test.
- [ ] Clean Architecture boundaries are intact.
- [ ] No unauthorized `git commit` was created.

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

Never commit `.env.production`. Use `flutter_dotenv` to load these values securely.

## 3. Testing Policy

- **Unit Tests:** `test/core/` and `test/features/*/domain` or `data` layers.
- **Widget Tests:** `test/features/*/presentation/` using `bloc_test` and `mocktail`.
- **Integration Tests:** (Coming soon) For full end-to-end flows like daily planning or Google Calendar sync.

Read the full testing policy in [`docs/testing.md`](docs/testing.md).

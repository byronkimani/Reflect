# Code Generation — Reflect

Reflect relies heavily on Dart's `build_runner` for generating boilerplate code. 

## What gets generated?

| Package | Used For | Output |
|---------|----------|--------|
| **Freezed** | Immutability, pattern matching (States, Events, Entities) | `*.freezed.dart` |
| **JSON Serializable** | JSON parsing (Network models, DTOs) | `*.g.dart` |
| **Drift** | Reactive SQLite Database | `app_database.g.dart` |

## When to run Code Generation

You **must** run code generation whenever you:
- Create or modify a class annotated with `@freezed`.
- Create or modify a class annotated with `@JsonSerializable`.
- Create or modify a Drift `Table`, `DAO`, or the `AppDatabase`.

## Commands

We have defined shortcuts in our `Makefile`.

### 1. One-shot generation (Recommended)

Run this after making your changes:

```bash
make gen
```
*(Maps to `dart run build_runner build --delete-conflicting-outputs`)*

### 2. Watch mode (For active development)

If you are rapidly modifying models, run this in a separate terminal tab:

```bash
make watch
```
*(Maps to `dart run build_runner watch --delete-conflicting-outputs`)*

## Gotchas

- **CI Failure:** If you commit modified annotated classes without running `make gen`, the CI pipeline will fail because the generated files will be out of sync.
- **Git:** Generated files (`*.freezed.dart`, `*.g.dart`) are checked into source control to speed up CI builds and reduce dev onboarding time.

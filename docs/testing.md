# Testing guide — Reflect

How we test this repo. **Tests ship with every change** — see rule 1 in [`AGENTS.md`](../AGENTS.md).

## Iron rule

Every new or changed behavior must include tests before merge:

- At least one **happy-path** and one **failure/edge** test
- **Unit** tests for domain / data / core
- **Widget** tests for presentation UI
- **bloc_test** for BLoC / Cubit

Filtered coverage from `make coverage` must stay **≥ 99%** in CI. Same file exclusions as CI.

**Coverage baseline (Jul 2026):** **100%** filtered line coverage on in-scope `lib/` lines. CI enforces **99%**.

### Coverage exclusions (filtered before the gate)

`make coverage` and CI apply the same `lcov --remove` patterns. **Generated artifacts**, **Drift schema DSL** (`tables/*`), and **`main.dart`** are excluded.

| Pattern | Files | Rationale |
|---------|-------|-----------|
| `*.g.dart` | 5 | **Generated** — `json_serializable`, Drift |
| `*.freezed.dart` | 14 | **Generated** — Freezed unions/copyWith |
| `*firebase_options.dart` | 1 | **Generated** — FlutterFire config |
| `*/l10n/*` | 3 | **Generated** — `flutter gen-l10n` |
| `*/tables/*` | 3 | **Drift schema DSL** — column getters are compile-time only (not runtime-executable); logic covered via migrations/DAOs |
| `*/main.dart` | 1 | **Prod entry** — thin `bootstrapReflectApp` + `runApp` shell |

**In-scope (must be covered):** `injectors.dart`, `app_theme.dart`, `app_bootstrap.dart`, `app_database.dart` (including production open paths), and all feature code.

### Intentionally ignored lines (`// coverage:ignore-line`)

`lcov --remove` only excludes whole files. Lines that are structurally uncoverable or prod-only Firebase wiring are marked in source:

| File | Lines | Rationale |
|------|-------|-----------|
| `failure_mapper.dart` | private ctor | Never instantiated |
| `notification_routes.dart` | private ctor | Static-only utility |
| `production_env_validator.dart` | private ctor | Static-only utility |
| `secure_storage_factory.dart` | private ctor | Static `instance` only |
| `sqlcipher_key.dart` | private ctor | Static `apply` only |
| `app_bootstrap.dart` | default `initFirebase` | `Firebase.initializeApp` conflicts with test mocks |
| `injectors.dart` | `FirebaseAppAnalyticsService()` registration | Hits `FirebaseAnalytics.instance` without device Firebase |
| `analytics_service.dart` | `FirebaseAnalytics.instance` fallback | Same — all tests inject a mock analytics instance |
| `crash_reporter.dart` | `NoOpCrashReporter` ctor | Const ctor line not attributed when behavior is tested elsewhere |

**Testing pyramid for new tests:** prioritize **unit** tests (domain, data, core utils, network), then **widget** tests for shared components, then **page interaction** widget tests. Each behavior needs happy-path **and** failure/edge coverage.

## Coverage Expectations

| Layer | Testing Focus | Tool / Approach |
|-------|---------------|-----------------|
| `domain` / `data` | High coverage. Test all logic, mappers, and DAOs. | Unit tests (`flutter_test`), mocked dependencies (`mocktail`), in-memory SQLite. |
| `presentation` (BLoC) | State transitions and event mapping. | `bloc_test` |
| `presentation` (UI) | Smoke tests, user interactions, error states. | Widget tests (`flutter_test`) |
| Core flows | End-to-end integration (Task creation, planning, etc). | Integration tests (`integration_test`) - *Planned* |

**Edge cases are mandatory:** Each behavior needs at least one non-happy path (e.g., empty state, validation failure, API error). Happy-path-only tests are insufficient.

## Commands

Run lint before tests locally and in CI. `make lint` must report **zero** analyzer issues (errors, warnings, and info).

```bash
make lint             # Static analysis (must be clean before merge)
make test             # Run all unit and widget tests
make coverage         # Generate lcov report (filtered ≥ 99% CI gate)
make coverage-check   # Print filtered line coverage summary
```

## Mocking dependencies

We use `mocktail` for mocking dependencies.

### Widget test helpers

| Helper | Path | Use for |
|--------|------|---------|
| `pumpMaterialPage` | `test/helpers/page_test_harness.dart` | Minimal `MaterialApp` scaffold wrapper |
| `SlidableTestHarness` | `test/helpers/slidable_test_harness.dart` | Open/tap `Slidable` end actions via `SlidableController` (prefer over raw drags) |

```dart
await SlidableTestHarness.performEndAction(
  tester,
  descendant: find.text('Remove me'),
  icon: Icons.delete_outline,
);
```

```dart
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements ITaskRepository {}

void main() {
  late MockTaskRepository repository;

  setUp(() {
    repository = MockTaskRepository();
  });
}
```

## BLoC Testing

Use `bloc_test` to test state emissions.

```dart
import 'package:bloc_test/bloc_test.dart';

blocTest<TaskListBloc, TaskListState>(
  'emits [loading, success] when LoadTasks is added',
  build: () {
    when(() => mockRepository.getTasks()).thenAnswer((_) async => right([]));
    return TaskListBloc(mockRepository);
  },
  act: (bloc) => bloc.add(LoadTasks()),
  expect: () => [
    TaskListState.loading(),
    TaskListState.success([]),
  ],
);
```

## Drift (Database) Testing

Use an in-memory SQLite database for repository tests.

```dart
import 'package:drift/native.dart';

AppDatabase createTestDatabase() {
  return AppDatabase.forTesting(NativeDatabase.memory());
}
```

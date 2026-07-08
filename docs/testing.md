# Testing guide — Reflect

How we test this repo. **Tests ship with every change** — see rule 1 in [`AGENTS.md`](../AGENTS.md).

## Iron rule

Every new or changed behavior must include tests before merge:

- At least one **happy-path** and one **failure/edge** test
- **Unit** tests for domain / data / core
- **Widget** tests for presentation UI
- **bloc_test** for BLoC / Cubit

Filtered coverage from `make coverage` must stay **≥ 98%** (same file exclusions as CI) under normal development.

**UI refresh (2026):** The 98% CI gate is **temporarily disabled** while the redesigned screens land. Tests still run in CI; `make test` must pass locally. Coverage will be restored to ≥ 98% in a follow-up session after UI sign-off and App Tester validation.

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
make coverage         # Generate lcov report (filtered ≥ 98% required)
```

## Mocking dependencies

We use `mocktail` for mocking dependencies.

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

# Testing guide — Reflect

How we test this repo. Testing is mandatory for all new logic.

## Coverage Expectations

| Layer | Testing Focus | Tool / Approach |
|-------|---------------|-----------------|
| `domain` / `data` | High coverage. Test all logic, mappers, and DAOs. | Unit tests (`flutter_test`), mocked dependencies (`mocktail`), in-memory SQLite. |
| `presentation` (BLoC) | State transitions and event mapping. | `bloc_test` |
| `presentation` (UI) | Smoke tests, user interactions, error states. | Widget tests (`flutter_test`) |
| Core flows | End-to-end integration (Task creation, planning, etc). | Integration tests (`integration_test`) - *Planned* |

**Edge cases are mandatory:** Each behavior needs at least one non-happy path (e.g., empty state, validation failure, API error). Happy-path-only tests are insufficient.

## Commands

```bash
make test             # Run all unit and widget tests
make coverage         # Generate lcov report
make lint             # Run static analysis
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

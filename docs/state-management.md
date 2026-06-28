# State Management — Reflect

We strictly use the **BLoC** (Business Logic Component) pattern. We do not use `setState`, `ChangeNotifier`, or Riverpod.

## BLoC vs Cubit

- **BLoC:** Use for complex, event-driven features where you need to track exactly *what* triggered a state change, or when you need advanced event transformations (debounce, throttle, switchMap). Example: `TaskListBloc`.
- **Cubit:** Use for simpler state management where functions can be called directly from the UI. Example: `PlanningCubit`, `SettingsCubit`.

## HydratedBloc

For state that must persist across app restarts (like user preferences or theme mode), use `HydratedBloc` or `HydratedCubit`. Example: `SettingsCubit`.

## State and Event Design

All States and Events must use `@freezed` to enforce immutability and provide sealed unions (for pattern matching).

### Event Example

```dart
@freezed
class TaskListEvent with _$TaskListEvent {
  const factory TaskListEvent.loadTasksForDate(DateTime date) = _LoadTasksForDate;
  const factory TaskListEvent.taskToggled(Task task) = _TaskToggled;
}
```

### State Example

```dart
@freezed
class TaskListState with _$TaskListState {
  const factory TaskListState.initial() = _Initial;
  const factory TaskListState.loading() = _Loading;
  const factory TaskListState.loaded(List<Task> tasks) = _Loaded;
  const factory TaskListState.error(String message) = _Error;
}
```

*Note: You must run `make gen` after defining Freezed classes.*

## Dependency Injection for BLoCs

Global BLoCs (needed everywhere, like `SettingsCubit` or `ConnectivityBloc`) are injected in `app.dart` using a `MultiBlocProvider`.

Feature-scoped BLoCs (only needed in a specific screen) should be injected within the GoRouter configuration (`app_router.dart`) or right above the specific page widget.

## Clean Architecture Boundary

BLoCs and Cubits belong in the **Presentation** layer.
They **must not** contain business logic or formatting logic. They simply receive events from the UI, call the Domain layer (Use Cases or Repositories), and emit new states back to the UI.

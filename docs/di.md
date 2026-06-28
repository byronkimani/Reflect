# Dependency Injection (DI) — Reflect

We use [GetIt](https://pub.dev/packages/get_it) as our service locator / dependency injection container.

## Setup

All dependencies are registered in `lib/core/di/injectors.dart`. The `setupDependencies()` function is called once in `main.dart` before `runApp`.

## Registration Types

We primarily use two registration types:

1. **`registerLazySingleton`**: Creates a single instance the first time it is requested, and returns the same instance on subsequent calls. Use this for Repositories, Services, Databases, and global objects.
2. **`registerFactory`**: Creates a new instance every time it is requested. Use this for feature-specific BLoCs or Cubits, so that navigating to a page creates a fresh state.

### Example Registration

```dart
void setupDependencies() {
  // Database (Singleton)
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Repository (Singleton, depends on Database)
  getIt.registerLazySingleton<ITaskRepository>(
    () => TaskRepositoryImpl(getIt<AppDatabase>()),
  );

  // BLoC (Factory, depends on Repository)
  getIt.registerFactory<TaskListBloc>(
    () => TaskListBloc(getIt<ITaskRepository>()),
  );
}
```

## Consuming Dependencies

To consume a dependency, call `getIt<T>()`.

### In `app.dart` or Routers (For BLoC Provisioning)

```dart
BlocProvider<TaskListBloc>(
  create: (_) => getIt<TaskListBloc>()..add(LoadTasks()),
)
```

**CRITICAL RULE:** Do **not** use `getIt<T>()` directly inside UI Widgets (e.g., `build` methods). Widgets should only access data via BLoC/Cubit states using `BlocBuilder` or `context.read()`.

## Testing

In unit tests, you can mock dependencies without using `GetIt` by simply passing the mock directly into the constructor.

```dart
final mockRepo = MockTaskRepository();
final bloc = TaskListBloc(mockRepo);
```

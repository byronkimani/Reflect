# Google Calendar Sync — Reflect

Reflect is primarily an offline-first app. However, it provides optional syncing of planned tasks to Google Calendar to help users timeblock their day.

## Architecture

The sync engine uses the **Outbox Pattern** to ensure reliability even if the user creates a task while offline.

1. **Local Save:** When a user creates a task and selects "Sync to GCal", the task is saved in the local Drift database along with a sync flag (`needsSync = true`).
2. **Background Processing:** The `GCalSyncCubit` periodically checks the local database for tasks with `needsSync = true`.
3. **API Request:** It takes the pending tasks and pushes them to the Google Calendar API via `GCalApiService`.
4. **Update State:** On success, it clears the `needsSync` flag and stores the returned Google Calendar Event ID so the task can be updated or deleted later.

## Components

The implementation is located in `lib/features/gcal/`.

- `GCalApiService`: Handles HTTP calls to the Google Calendar API.
- `GCalRepositoryImpl`: Implements the domain interface, coordinating between Drift (to get pending syncs) and the `GCalApiService`.
- `GCalSyncCubit`: The state management component that runs the queue periodically.

## Initialization

The `GCalSyncCubit` is provided globally in `app.dart` and starts processing the queue immediately upon app launch.

```dart
BlocProvider<GCalSyncCubit>(
  create: (_) => getIt<GCalSyncCubit>()..processQueue(),
),
```

## Error Handling

If an API call fails (e.g., due to no internet connection), the `needsSync` flag remains true. The cubit will automatically retry the operation during its next processing cycle or when the device regains connectivity (triggered by `ConnectivityBloc`).

## Future Enhancements

- **Two-way sync:** Currently, the sync is mostly one-way (Reflect -> GCal). Pulling events from GCal into Reflect is planned for a future update.

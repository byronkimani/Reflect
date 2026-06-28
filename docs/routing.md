# Routing — Reflect

We use [GoRouter](https://pub.dev/packages/go_router) for declarative routing and deep linking. 

The main configuration is located in `lib/core/router/app_router.dart`.

## Navigation Architecture

Reflect uses a **Bottom Navigation Bar** approach. We implement this using GoRouter's `StatefulShellRoute.indexedStack`. This ensures that each tab maintains its own navigation state (e.g., if you push a detail page in the "Tasks" tab, switch to "Settings", and switch back to "Tasks", the detail page remains visible).

### The Shell Branches

1. **Today**: `/today`
2. **Backlog**: `/backlog`
3. **Goals**: `/goals`
4. **Reflect**: `/reflect`
5. **More (Settings/Analytics)**: `/more`

## Adding a New Route

To add a new route:

1. **Sub-route:** If it belongs to a specific tab, add it to that tab's `routes` list.
2. **Parent Navigator Key:** If you want the route to hide the bottom navigation bar (full-screen push), provide `parentNavigatorKey: rootNavigatorKey`.

```dart
GoRoute(
  path: 'task/:id',
  parentNavigatorKey: rootNavigatorKey, // Hides bottom bar
  builder: (context, state) {
    final id = state.pathParameters['id'];
    return TaskDetailPage(taskId: id);
  },
),
```

## Navigation Commands

Use `context.go()` or `context.push()`.

- **`context.go('/path')`**: Replaces the navigation stack. Good for switching tabs or going to root locations.
- **`context.push('/path')`**: Pushes a new page on top of the current stack. Allows the user to pop back.

**CRITICAL RULE:** Do not hardcode string paths in UI widgets. If a path is used in multiple places, define it as a constant in `app_router.dart` (e.g., `static const taskDetail = 'task/:id';`).

## Passing Data

Pass simple IDs via path parameters (`state.pathParameters['id']`). Pass complex objects using the `extra` parameter, but ensure your app handles cases where `extra` is null (e.g., via deep linking).

```dart
context.push('/today/task/123', extra: myTaskObject);
```

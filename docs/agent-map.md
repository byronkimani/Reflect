# Agent Map — Reflect

Fast task-to-file lookup. Read [`../AGENTS.md`](../AGENTS.md) first, then [`../ARCHITECTURE.md`](../ARCHITECTURE.md).

## Start order

1. [`../AGENTS.md`](../AGENTS.md) — Guardrails
2. [`../ARCHITECTURE.md`](../ARCHITECTURE.md) — Boundaries
3. [`implementation-status.md`](implementation-status.md) — Delivery state
4. This map → code

## Feature map

| If you are changing... | Read first | Then inspect code | Tests |
|---|---|---|---|
| Task CRUD / recurrence | `../AGENTS.md` | `lib/features/tasks/` | `test/features/tasks/` |
| Daily planning flow | — | `lib/features/planning/` | `test/features/planning/` |
| Evening review | — | `lib/features/review/` | `test/features/review/` |
| Goals | — | `lib/features/goals/` | `test/features/goals/` |
| Analytics / charts | — | `lib/features/analytics/` | `test/features/analytics/` |
| GCal sync | `gcal-sync.md` | `lib/features/gcal/` | `test/features/gcal/` |
| Notifications | `notifications.md` | `lib/features/notifications/` | — |
| Settings / theme | — | `lib/features/settings/`, `lib/core/presentation/theme/` | — |
| Theme / shared UI widgets | — | `lib/core/presentation/theme/`, `lib/core/presentation/widgets/` | `test/core/presentation/` |
| Database schema / migrations | `database.md` | `lib/core/storage/database/` | `test/core/` |
| DI / service registration | `di.md` | `lib/core/di/injectors.dart` | — |
| Routing | `routing.md` | `lib/core/router/app_router.dart` | — |
| Network / Dio | — | `lib/core/network/` | — |
| Env config | — | `lib/core/config/`, `env/active.env.example` | `test/core/config/` |
| Security / secrets / encryption | `security.md` | `lib/core/errors/failure_mapper.dart`, `lib/core/storage/` | `test/core/errors/` |

## Shared folders

| Folder | Open when... |
|---|---|
| `lib/core/di/` | Registering new dependencies |
| `lib/core/router/` | Adding or changing routes |
| `lib/core/storage/database/` | Schema changes, new DAOs, migrations |
| `lib/core/presentation/` | App-level shared widgets (scaffold, wrappers) |
| `lib/core/theme/` | Changing design tokens, colors, typography |
| `lib/core/extensions/` | Adding Dart extension methods |
| `lib/core/errors/` | Error types and failure handling |
| `lib/l10n/` | Adding/modifying translations |

# Documentation index — Reflect

Source-of-truth specs for product behavior and engineering conventions. Structural maps live in [`../ARCHITECTURE.md`](../ARCHITECTURE.md); coding rules in [`../AGENTS.md`](../AGENTS.md).

## Read order

1. [`../ARCHITECTURE.md`](../ARCHITECTURE.md) — System boundaries and architecture
2. [`../AGENTS.md`](../AGENTS.md) — AI agent guardrails and coding rules
3. [`implementation-status.md`](implementation-status.md) — What is shipped vs in-progress vs planned
4. Feature spec for the area you are changing (below)

## Engineering Specs

| Spec | Status | Notes |
|------|--------|-------|
| [`testing.md`](testing.md) | Active | Testing strategy, Vitest/Widget equivalents, Mocktail |
| [`state-management.md`](state-management.md) | Active | BLoC/Cubit conventions, HydratedBloc |
| [`database.md`](database.md) | Active | Drift (SQLite), schema, migrations, DAOs |
| [`code-generation.md`](code-generation.md) | Active | Freezed, JSON Serializable, Drift build_runner |
| [`di.md`](di.md) | Active | Dependency injection using GetIt |
| [`routing.md`](routing.md) | Active | GoRouter setup, navigation patterns |
| [`agent-map.md`](agent-map.md) | Active | Task to file lookup for AI agents |
| [`collaboration-framework.md`](collaboration-framework.md) | Active | AI-Human collaboration and brainstorming rules |

## Feature Specs

| Spec | Status | Notes |
|------|--------|-------|
| [`notifications.md`](notifications.md) | Active | Local notifications, scheduling, permissions |
| [`gcal-sync.md`](gcal-sync.md) | Active | Background sync, outbox pattern, Google Calendar API |

*(More feature specs will be added as product areas like Planning, Reviews, and Analytics are detailed.)*

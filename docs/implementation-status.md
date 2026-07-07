# Implementation status — Reflect

Live matrix of routes, data sources, and delivery state. Update this file when shipping or deferring features.

Legend: **Shipped** | **In Progress** | **Planned** | **Deferred**

| Feature | UI | Data Layer | BLoC/Cubit | Status |
|---------|-----|-----------|------------|--------|
| Task CRUD | ✅ | ✅ Drift | ✅ TaskListBloc | Shipped |
| Backlog | ✅ | ✅ Drift | ✅ TaskListBloc | Shipped |
| Recurrence engine | ✅ | ✅ | ✅ | Shipped |
| Daily planning | ✅ | ✅ | ✅ PlanningCubit | Shipped |
| Daily review | ✅ | ✅ | ✅ DailyReviewCubit | Shipped |
| Goals | ✅ | ✅ | ✅ GoalsCubit | Shipped |
| Analytics | ✅ | ✅ AnalyticsDao | ✅ AnalyticsBloc | Shipped |
| Crashlytics | ✅ | — | — | Global error handlers + `FirebaseCrashReporter` |
| Product analytics (Firebase) | ✅ | — | ✅ Settings opt-in | Opt-in; `task_created`, `daily_review_submitted`, `planning_completed` |
| Settings (theme, heartbeat) | ✅ | HydratedBloc | ✅ SettingsCubit | Shipped |
| Local notifications | — | ✅ | — | Shipped |

## Core Infrastructure

| Layer | Status | Notes |
|-------|--------|-------|
| Database (Drift) | Shipped | SQLCipher encryption; fresh-start on first encrypted upgrade |
| Dependency Injection | Shipped | GetIt fully integrated |
| Navigation | Shipped | GoRouter with StatefulShellRoute |
| API/Networking | Shipped | Dio + auth refresh mutex; sanitized failures |
| Security hardening | Shipped | See [`security.md`](security.md) |
| Analytics charts | Shipped | Using `fl_chart` |

# Source Tree — Reflect

This provides a structural map of the `lib/` directory, reflecting our Feature-Driven Clean Architecture approach.

```text
lib/
├── main.dart                         # App entry, binding init, DI setup, notifications
├── app.dart                          # ReflectApp widget, MultiBlocProvider, MaterialApp.router
├── core/                             # Shared infrastructure (never feature-specific)
│   ├── config/                       # EnvConfig (.env loading)
│   ├── di/injectors.dart             # GetIt service registrations
│   ├── errors/                       # Failure types, error handling
│   ├── extensions/                   # Dart extension methods
│   ├── network/                      # Dio client, auth interceptor, network info
│   │   └── presentation/             # ConnectivityBloc
│   ├── presentation/                 # AppScaffold, ConnectivityWrapper, theme
│   ├── router/app_router.dart        # GoRouter config (all routes)
│   ├── storage/                      # TokenStorage + Drift database
│   │   └── database/                 # AppDatabase, tables, DAOs
│   ├── theme/                        # Design tokens, AppTheme
│   └── utils/                        # Shared utility functions
├── features/                         # Feature modules (Clean Architecture per feature)
│   ├── tasks/                        # Core task management
│   │   ├── data/                     # Drift models, TaskRepositoryImpl
│   │   ├── domain/                   # Task entity (@freezed), ITaskRepository, RecurrenceEngine
│   │   └── presentation/             # TaskListBloc, TodayPage, BacklogPage, TaskDetailPage
│   ├── planning/                     # Morning planning flow
│   ├── review/                       # Evening review / daily reflection
│   ├── reviews/                      # Weekly/monthly reviews (Planned)
│   ├── goals/                        # Goal tracking
│   ├── analytics/                    # Data visualizations (fl_chart)
│   ├── gcal/                         # Google Calendar outbox sync
│   ├── notifications/                # Local notification scheduling
│   ├── settings/                     # App preferences & theme mode (HydratedBloc)
│   ├── profile/                      # User profile
│   ├── post/                         # Posts/feed (API-backed, planned)
│   ├── insights/                     # Insights page
│   └── more/                         # "More" tab hub page
└── l10n/                             # Localization (ARB files, AppLocalizations)
```

## Layer Responsibilities (Within Features)

- **`presentation/`**: Contains BLoCs/Cubits, Pages, and Widgets. Depends on `domain/`. Knows nothing about `data/`.
- **`domain/`**: Contains Entities (`@freezed`), Repository Interfaces, and Use Cases / Domain Services. Does not import Flutter UI code or `data/` code.
- **`data/`**: Contains DTOs/Drift Models, external API services, and Repository Implementations. Depends on `domain/`.

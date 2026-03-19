# Reflect

Reflect is a powerful, offline-first personal task manager and wellness tool designed for high-agency individuals who value privacy and focus. It combines daily planning, deep reflection, and advanced task recurrence into a single, cohesive experience.

## ✨ Core Features

-   **Daily Planning**: Set your intentions every morning and audit your progress every evening.
-   **Intelligent Backlog**: Organize tasks that aren't quite ready for today’s list.
-   **Recurring Engine**: Powerful recurrence support (Daily, Weekly, Monthly, Yearly) with custom rules.
-   **Analytics & Insights**: Beautiful visualizations of your streaks, completion rates, and focus areas using `fl_chart`.
-   **Offline First**: Built with SQLite via `drift`. Your data stays on your device.
-   **GCal Sync Outbox**: Queue and sync your tasks to Google Calendar when online.
-   **Local Notifications**: Privacy-respecting heartbeat reminders to keep you on track.

## 🏗 Architecture

The project follows a **Feature-Driven Clean Architecture**, ensuring high modularity and testability.

```text
lib/
├── core/               # Shared infrastructure (DI, DB, Networking, Router)
├── features/
│   ├── tasks/          # Task management & Backlog
│   ├── planning/       # Daily intentions & Morning flow
│   ├── review/         # Evening reflection & Weekly/Monthly reviews
│   ├── analytics/      # Insights & Data visualization
│   └── notifications/  # Local scheduling & Permissions
└── main.dart           # App entry point & initialization
```

## 🛠 Tech Stack

| Technology | Purpose |
| :--- | :--- |
| **Flutter** | Cross-platform UI Framework |
| **Drift (Moor)** | Reactive SQLite Database |
| **BLoC / Cubit** | State Management |
| **Freezed** | Immutability & Data Modeling |
| **GoRouter** | Declarative Routing & Deep Linking |
| **fl_chart** | Data Visualizations |
| **GetIt** | Dependency Injection |

## 🚀 Getting Started

### Prerequisites

-   Flutter SDK installed (`flutter doctor` should be green).
-   CocoaPods (for iOS).

### Setup

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/byronkimani/reflect.git
    cd reflect
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Generate Code (CRITICAL)**:
    Reflect relies heavily on code generation for database schemas and immutable models.
    ```bash
    dart run build_runner build -d
    ```

4.  **Run the application**:
    ```bash
    flutter run
    ```

## 🧪 Testing

We aim for high coverage across our core logic and data aggregations.

Run the test suite using:
```bash
flutter test
```

***

*Built with ❤️ for focused minds.*

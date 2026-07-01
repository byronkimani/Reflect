/// Validates and normalizes notification tap payloads before navigation.
class NotificationRoutes {
  NotificationRoutes._();

  static const _allowedExactRoutes = {
    '/today',
    '/today/planning',
    '/today/review',
    '/backlog',
    '/goals',
    '/reflect',
    '/more',
    '/more/settings',
    '/more/analytics',
  };

  /// Returns a safe in-app route, or `null` if the payload must be ignored.
  static String? normalize(String? payload) {
    if (payload == null || payload.isEmpty) return null;

    final route = payload.startsWith('/') ? payload : '/$payload';

    if (_allowedExactRoutes.contains(route)) return route;

    if (_isTaskRoute(route)) return route;

    // Legacy task reminder format: /task/:id
    final legacyTask = RegExp(r'^/task/([a-zA-Z0-9_-]+)$').firstMatch(route);
    if (legacyTask != null) {
      return '/today/task/${legacyTask.group(1)}';
    }

    return null;
  }

  static bool isAllowed(String route) => normalize(route) != null;

  static bool _isTaskRoute(String route) {
    return RegExp(r'^/today/task/[a-zA-Z0-9_-]+$').hasMatch(route) ||
        RegExp(r'^/backlog/task/[a-zA-Z0-9_-]+$').hasMatch(route);
  }
}

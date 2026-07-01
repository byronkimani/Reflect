import 'package:flutter/foundation.dart';

enum AuthSessionEvent { expired }

/// Broadcasts auth session lifecycle events (e.g. refresh token failure).
class AuthSessionNotifier extends ChangeNotifier {
  AuthSessionEvent? _lastEvent;

  AuthSessionEvent? get lastEvent => _lastEvent;

  void notifySessionExpired() {
    _lastEvent = AuthSessionEvent.expired;
    notifyListeners();
  }

  @visibleForTesting
  void reset() {
    _lastEvent = null;
  }
}

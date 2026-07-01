import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/network/auth_session_notifier.dart';

void main() {
  test('notifySessionExpired sets lastEvent and notifies listeners', () {
    final notifier = AuthSessionNotifier();
    var notified = false;
    notifier.addListener(() => notified = true);

    notifier.notifySessionExpired();

    expect(notifier.lastEvent, AuthSessionEvent.expired);
    expect(notified, isTrue);
  });

  test('reset clears lastEvent', () {
    final notifier = AuthSessionNotifier();
    notifier.notifySessionExpired();

    notifier.reset();

    expect(notifier.lastEvent, isNull);
  });
}

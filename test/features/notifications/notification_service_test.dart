import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/router/app_router.dart';
import 'package:reflect/features/notifications/notification_service.dart';

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

class MockIOSFlutterLocalNotificationsPlugin extends Mock
    implements IOSFlutterLocalNotificationsPlugin {}

class MockAndroidFlutterLocalNotificationsPlugin extends Mock
    implements AndroidFlutterLocalNotificationsPlugin {}

NotificationResponse _response({String? payload}) {
  return NotificationResponse(
    notificationResponseType: NotificationResponseType.selectedNotification,
    payload: payload,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
  });

  group('NotificationService.handleNotificationResponse', () {
    test('invokes route handler when payload is present', () {
      String? capturedRoute;
      final service = NotificationService(
        onNotificationRoute: (route) => capturedRoute = route,
      );

      service.handleNotificationResponse(_response(payload: '/today/task/1'));

      expect(capturedRoute, '/today/task/1');
    });

    test('ignores null payload', () {
      var called = false;
      final service = NotificationService(
        onNotificationRoute: (_) => called = true,
      );

      service.handleNotificationResponse(_response());

      expect(called, isFalse);
    });

    test('ignores disallowed payload', () {
      var called = false;
      final service = NotificationService(
        onNotificationRoute: (_) => called = true,
      );

      service.handleNotificationResponse(_response(payload: '/admin'));

      expect(called, isFalse);
    });

    test('normalizes legacy task payload before routing', () {
      String? capturedRoute;
      final service = NotificationService(
        onNotificationRoute: (route) => capturedRoute = route,
      );

      service.handleNotificationResponse(_response(payload: '/task/42'));

      expect(capturedRoute, '/today/task/42');
    });

    test('ignores empty payload', () {
      var called = false;
      final service = NotificationService(
        onNotificationRoute: (_) => called = true,
      );

      service.handleNotificationResponse(_response(payload: ''));

      expect(called, isFalse);
    });

    testWidgets('pushes route via root navigator when no handler is set', (
      tester,
    ) async {
      final router = GoRouter(
        navigatorKey: rootNavigatorKey,
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(body: Text('Home')),
          ),
          GoRoute(
            path: '/today/planning',
            builder: (_, _) => const Scaffold(body: Text('Destination')),
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      final service = NotificationService();
      service.handleNotificationResponse(_response(payload: '/today/planning'));
      await tester.pumpAndSettle();

      expect(find.text('Destination'), findsOneWidget);
    });
  });

  group('NotificationService.requestPermissions', () {
    late MockFlutterLocalNotificationsPlugin mockPlugin;
    late MockIOSFlutterLocalNotificationsPlugin mockIos;
    late MockAndroidFlutterLocalNotificationsPlugin mockAndroid;

    setUp(() {
      mockPlugin = MockFlutterLocalNotificationsPlugin();
      mockIos = MockIOSFlutterLocalNotificationsPlugin();
      mockAndroid = MockAndroidFlutterLocalNotificationsPlugin();
    });

    test('requests iOS permissions when platform target is ios', () async {
      when(
        () => mockPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>(),
      ).thenReturn(mockIos);
      when(
        () => mockIos.requestPermissions(
          alert: any(named: 'alert'),
          badge: any(named: 'badge'),
          sound: any(named: 'sound'),
        ),
      ).thenAnswer((_) async => true);

      final service = NotificationService(
        notificationsPlugin: mockPlugin,
        platformTarget: NotificationPlatformTarget.ios,
      );

      await service.requestPermissions();

      verify(
        () => mockIos.requestPermissions(alert: true, badge: true, sound: true),
      ).called(1);
    });

    test('requests Android permissions when platform target is android', () async {
      when(
        () => mockPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>(),
      ).thenReturn(mockAndroid);
      when(() => mockAndroid.requestNotificationsPermission())
          .thenAnswer((_) async => true);
      when(() => mockAndroid.requestExactAlarmsPermission())
          .thenAnswer((_) async => true);

      final service = NotificationService(
        notificationsPlugin: mockPlugin,
        platformTarget: NotificationPlatformTarget.android,
      );

      await service.requestPermissions();

      verify(() => mockAndroid.requestNotificationsPermission()).called(1);
      verify(() => mockAndroid.requestExactAlarmsPermission()).called(1);
    });

    test('does nothing when platform target is other', () async {
      final service = NotificationService(
        notificationsPlugin: mockPlugin,
        platformTarget: NotificationPlatformTarget.other,
      );

      await expectLater(service.requestPermissions(), completes);

      verifyNever(
        () => mockPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>(),
      );
      verifyNever(
        () => mockPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>(),
      );
    });
  });

  test('init delegates to notifications plugin', () async {
    final mockPlugin = MockFlutterLocalNotificationsPlugin();
    when(
      () => mockPlugin.initialize(
        settings: any(named: 'settings'),
        onDidReceiveNotificationResponse: any(
          named: 'onDidReceiveNotificationResponse',
        ),
      ),
    ).thenAnswer((_) async => true);

    final service = NotificationService(notificationsPlugin: mockPlugin);
    await service.init();

    verify(
      () => mockPlugin.initialize(
        settings: any(named: 'settings'),
        onDidReceiveNotificationResponse: any(
          named: 'onDidReceiveNotificationResponse',
        ),
      ),
    ).called(1);
  });

  test('platformTarget uses injected value when provided', () {
    final service = NotificationService(
      platformTarget: NotificationPlatformTarget.other,
    );

    expect(service.platformTarget, NotificationPlatformTarget.other);
  });

  test('platformTarget falls back to runtime detection when not injected', () {
    final service = NotificationService();

    expect(service.platformTarget, isA<NotificationPlatformTarget>());
  });

  group('NotificationService.resolvePlatform', () {
    test('returns ios for iOS and macOS targets', () {
      expect(
        NotificationService.resolvePlatform(
          isWeb: false,
          isIOS: true,
          isMacOS: false,
          isAndroid: false,
        ),
        NotificationPlatformTarget.ios,
      );
      expect(
        NotificationService.resolvePlatform(
          isWeb: false,
          isIOS: false,
          isMacOS: true,
          isAndroid: false,
        ),
        NotificationPlatformTarget.ios,
      );
    });

    test('returns android for Android target', () {
      expect(
        NotificationService.resolvePlatform(
          isWeb: false,
          isIOS: false,
          isMacOS: false,
          isAndroid: true,
        ),
        NotificationPlatformTarget.android,
      );
    });

    test('returns other for web and unknown platforms', () {
      expect(
        NotificationService.resolvePlatform(
          isWeb: true,
          isIOS: false,
          isMacOS: false,
          isAndroid: false,
        ),
        NotificationPlatformTarget.other,
      );
      expect(
        NotificationService.resolvePlatform(
          isWeb: false,
          isIOS: false,
          isMacOS: false,
          isAndroid: false,
        ),
        NotificationPlatformTarget.other,
      );
    });
  });
}

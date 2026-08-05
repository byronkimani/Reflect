import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/startup/reflect_launch_overlay.dart';

void main() {
  group('ReflectLaunchOverlay', () {
    testWidgets('shows aligned splash on iOS until overlay is dismissed', (
      tester,
    ) async {
      final events = <String>[];

      await tester.pumpWidget(
        MaterialApp(
          home: ReflectLaunchOverlay(
            showIosOverlay: () => true,
            removeNativeSplash: () => events.add('native_removed'),
            onNativeSplashRemoved: () => events.add('native_callback'),
            onOverlayHidden: () => events.add('overlay_hidden'),
            child: const SizedBox.shrink(),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);

      await tester.pump();
      expect(events, containsAll(['native_removed', 'native_callback']));
      expect(find.byType(Image), findsOneWidget);

      await tester.pump();
      expect(find.byType(Image), findsNothing);
      expect(events, contains('overlay_hidden'));
    });

    testWidgets('does not show overlay on Android', (tester) async {
      var nativeRemoved = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ReflectLaunchOverlay(
            showIosOverlay: () => false,
            removeNativeSplash: () => nativeRemoved = true,
            child: const Text('app'),
          ),
        ),
      );

      expect(find.byType(Image), findsNothing);
      expect(find.text('app'), findsOneWidget);

      await tester.pump();
      expect(nativeRemoved, isTrue);
      expect(find.byType(Image), findsNothing);
    });

    test('showIosOverlay is true when platform is iOS', () {
      expect(
        ReflectLaunchOverlay(
          showIosOverlay: () => true,
          child: const SizedBox.shrink(),
        ).showIosOverlay(),
        isTrue,
      );
    });
  });
}

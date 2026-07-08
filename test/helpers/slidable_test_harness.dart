import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';

/// Widget-test helpers for [Slidable] / [SlidableAction] interactions.
///
/// Prefer [openSlidableEndPane] (uses [SlidableController.openEndActionPane])
/// over raw drags — gesture simulation is flaky with [DrawerMotion] and scroll
/// parents.
class SlidableTestHarness {
  SlidableTestHarness._();

  /// Returns the [Slidable] ancestor of [descendant].
  static Finder slidableAncestorOf(Finder descendant) {
    return find.ancestor(
      of: descendant,
      matching: find.byType(Slidable),
    );
  }

  /// Resolves the [SlidableController] for the [Slidable] wrapping [descendant].
  static SlidableController controllerFor(
    WidgetTester tester,
    Finder descendant,
  ) {
    expect(descendant, findsOneWidget);
    final controller = Slidable.of(tester.element(descendant));
    expect(controller, isNotNull, reason: 'No SlidableController above $descendant');
    return controller!;
  }

  /// Opens the end action pane.
  ///
  /// Uses [Duration.zero] by default so widget tests do not hang on
  /// [pumpAndSettle] with [DrawerMotion].
  static Future<SlidableController> openEndPane(
    WidgetTester tester, {
    required Finder descendant,
    Duration animationDuration = Duration.zero,
  }) async {
    final controller = controllerFor(tester, descendant);
    await controller.openEndActionPane(duration: animationDuration);
    await tester.pump();
    if (animationDuration > Duration.zero) {
      await tester.pump(animationDuration);
    }
    return controller;
  }

  /// Opens the start action pane.
  static Future<SlidableController> openStartPane(
    WidgetTester tester, {
    required Finder descendant,
    Duration animationDuration = Duration.zero,
  }) async {
    final controller = controllerFor(tester, descendant);
    await controller.openStartActionPane(duration: animationDuration);
    await tester.pump();
    if (animationDuration > Duration.zero) {
      await tester.pump(animationDuration);
    }
    return controller;
  }

  /// Taps a [SlidableAction] inside the [Slidable] that wraps [descendant].
  static Future<void> tapAction(
    WidgetTester tester, {
    required Finder descendant,
    IconData? icon,
    String? label,
  }) async {
    final slidable = slidableAncestorOf(descendant);
    expect(slidable, findsOneWidget);

    Finder action;
    if (icon != null) {
      action = find.descendant(of: slidable, matching: find.byIcon(icon));
    } else if (label != null) {
      action = find.descendant(of: slidable, matching: find.text(label));
    } else {
      action = find.descendant(of: slidable, matching: find.byType(SlidableAction));
    }

    expect(action, findsOneWidget);
    await tester.tap(action);
    await tester.pump();
  }

  /// Opens the end pane, taps an action, and settles animations.
  static Future<void> performEndAction(
    WidgetTester tester, {
    required Finder descendant,
    IconData? icon,
    String? label,
  }) async {
    await openEndPane(tester, descendant: descendant);
    await tapAction(tester, descendant: descendant, icon: icon, label: label);
  }
}

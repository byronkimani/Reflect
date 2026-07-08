import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/common_app_bar.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';

void main() {
  testWidgets('CommonAppBar shows title on Material', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme.copyWith(platform: TargetPlatform.android),
        home: const Scaffold(
          appBar: CommonAppBar(title: 'Settings', showBackButton: false),
        ),
      ),
    );

    expect(find.text('Settings'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('CommonAppBar back button calls onBack', (tester) async {
    var back = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme.copyWith(platform: TargetPlatform.android),
        home: Scaffold(
          appBar: CommonAppBar(
            title: 'Detail',
            onBack: () => back = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(IconButton));
    expect(back, isTrue);
  });

  testWidgets('CommonAppBar shows actions on Material', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme.copyWith(platform: TargetPlatform.android),
        home: Scaffold(
          appBar: CommonAppBar(
            title: 'Settings',
            showBackButton: false,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.more_vert), findsOneWidget);
  });

  testWidgets('CommonAppBar uses CupertinoNavigationBar on iOS theme', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme.copyWith(platform: TargetPlatform.iOS),
        home: Scaffold(
          appBar: CommonAppBar(
            title: 'Review',
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.done)),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(CupertinoNavigationBar), findsOneWidget);
    expect(find.text('Review'), findsOneWidget);
    expect(find.byIcon(Icons.done), findsOneWidget);
  });

  testWidgets('CommonAppBar Cupertino back button calls onBack', (tester) async {
    var back = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme.copyWith(platform: TargetPlatform.iOS),
        home: Scaffold(
          appBar: CommonAppBar(
            title: 'Child',
            onBack: () => back = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(CupertinoButton));
    expect(back, isTrue);
  });
}

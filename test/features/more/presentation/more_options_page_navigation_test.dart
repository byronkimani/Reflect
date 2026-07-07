import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/features/more/presentation/pages/more_options_page.dart';

void main() {
  Widget buildApp() {
    return MaterialApp.router(
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const MoreOptionsPage(),
          ),
          GoRoute(
            path: '/more/settings',
            builder: (_, _) => const Scaffold(body: Text('Settings screen')),
          ),

        ],
      ),
    );
  }

  testWidgets('Settings row navigates to settings route', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Settings screen'), findsOneWidget);
  });


}

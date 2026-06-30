import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_state.dart';
import 'package:reflect/features/settings/presentation/pages/settings_page.dart';

class MockSettingsCubit extends Mock implements SettingsCubit {}

void main() {
  late MockSettingsCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(ThemeMode.system);
  });

  setUp(() {
    mockCubit = MockSettingsCubit();
    when(() => mockCubit.state).thenReturn(const SettingsState());
    when(() => mockCubit.stream).thenAnswer((_) => Stream.value(const SettingsState()));
  });

  Widget buildPage() {
    return MaterialApp(
      home: BlocProvider<SettingsCubit>.value(
        value: mockCubit,
        child: const SettingsPage(),
      ),
    );
  }

  group('SettingsPage', () {
    testWidgets('renders all settings elements', (tester) async {
      await tester.pumpWidget(buildPage());
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Appearance'), findsOneWidget);
      expect(find.text('Notifications'), findsOneWidget);
      
      expect(find.byType(SegmentedButton<ThemeMode>), findsOneWidget);
      expect(find.text('Morning planning'), findsOneWidget);
      expect(find.text('Evening review'), findsOneWidget);
      expect(find.text('Weekly planning'), findsOneWidget);
      expect(find.text('Monthly planning'), findsOneWidget);
    });

    testWidgets('interactions call cubit methods', (tester) async {
      when(() => mockCubit.setThemeMode(any())).thenReturn(null);
      when(() => mockCubit.setMorningPlanningEnabled(any())).thenAnswer((_) async {});
      when(() => mockCubit.setEveningReviewEnabled(any())).thenAnswer((_) async {});
      when(() => mockCubit.setWeeklyPlanningEnabled(any())).thenAnswer((_) async {});
      when(() => mockCubit.setMonthlyPlanningEnabled(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildPage());

      // Theme
      await tester.tap(find.text('Light'));
      await tester.pumpAndSettle();
      verify(() => mockCubit.setThemeMode(ThemeMode.light)).called(1);

      // Switches
      final switches = find.byType(Switch);
      expect(switches, findsNWidgets(4));

      await tester.tap(switches.at(0));
      verify(() => mockCubit.setMorningPlanningEnabled(false)).called(1);

      await tester.tap(switches.at(1));
      verify(() => mockCubit.setEveningReviewEnabled(false)).called(1);

      await tester.tap(switches.at(2));
      verify(() => mockCubit.setWeeklyPlanningEnabled(false)).called(1);

      await tester.tap(switches.at(3));
      verify(() => mockCubit.setMonthlyPlanningEnabled(false)).called(1);
    });
  });
}

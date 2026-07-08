import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_cubit.dart';
import 'package:reflect/features/tasks/presentation/pages/task_detail_page.dart';
import 'package:get_it/get_it.dart';

class MockITaskRepository extends Mock implements ITaskRepository {}

class MockIGoalRepository extends Mock implements IGoalRepository {}

void main() {
  late MockITaskRepository mockRepo;
  late MockIGoalRepository mockGoalRepo;

  setUp(() {
    mockRepo = MockITaskRepository();
    mockGoalRepo = MockIGoalRepository();

    final getIt = GetIt.instance;
    if (getIt.isRegistered<ITaskRepository>()) {
      getIt.unregister<ITaskRepository>();
    }
    if (getIt.isRegistered<IGoalRepository>()) {
      getIt.unregister<IGoalRepository>();
    }
    getIt.registerSingleton<ITaskRepository>(mockRepo);
    getIt.registerSingleton<IGoalRepository>(mockGoalRepo);

    when(
      () => mockGoalRepo.watchAllGoals(),
    ).thenAnswer((_) => Stream.value(const Right(<Goal>[])));
  });

  Widget buildTestWidget({Task? initialTask}) {
    return MaterialApp(
      home: BlocProvider<TaskFormCubit>(
        create: (_) => TaskFormCubit(mockRepo, mockGoalRepo, initialTask),
        child: const TaskFormView(),
      ),
    );
  }

  testWidgets('subtask field accepts very long text without overflow', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add step'));
    await tester.pumpAndSettle();

    const longText =
        'This is a very long subtask title that should be accepted by the form '
        'without throwing a layout overflow error in the widget test harness.';
    await tester.enterText(find.byType(TextFormField).last, longText);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text(longText), findsOneWidget);
  });
}

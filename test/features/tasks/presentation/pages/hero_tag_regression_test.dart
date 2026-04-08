import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_cubit.dart';

import 'package:reflect/features/tasks/presentation/pages/task_detail_page.dart';
import 'package:reflect/features/goals/presentation/pages/goal_form_page.dart';
import 'package:fpdart/fpdart.dart' hide Task;

class MockITaskRepository extends Mock implements ITaskRepository {}

class MockIGoalRepository extends Mock implements IGoalRepository {}

void main() {
  late MockITaskRepository mockTaskRepo;
  late MockIGoalRepository mockGoalRepo;

  setUp(() {
    mockTaskRepo = MockITaskRepository();
    mockGoalRepo = MockIGoalRepository();
    when(
      () => mockGoalRepo.watchCategories(),
    ).thenAnswer((_) => Stream.value(const Right([])));
    when(
      () => mockGoalRepo.watchAllGoals(),
    ).thenAnswer((_) => Stream.value(const Right([])));
  });

  testWidgets('Pushing multiple TaskDetailPages does not trigger Hero tag conflict', (
    tester,
  ) async {
    final task1 = Task(
      id: '1',
      title: 'Task 1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final task2 = Task(
      id: '2',
      title: 'Task 2',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Column(
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) =>
                            TaskFormCubit(mockTaskRepo, mockGoalRepo, task1),
                        child: const TaskFormView(),
                      ),
                    ),
                  ),
                  child: const Text('Push 1'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) =>
                            TaskFormCubit(mockTaskRepo, mockGoalRepo, task2),
                        child: const TaskFormView(),
                      ),
                    ),
                  ),
                  child: const Text('Push 2'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Push first page
    await tester.tap(find.text('Push 1'));
    await tester.pumpAndSettle();
    expect(find.text('Edit Task'), findsOneWidget);

    // Push second page WITHOUT popping first
    // In a real app, this might happen via a notification or deep link or quick tap
    // We use the navigator from the first pushed page's context or just the root
    final nav = tester.state<NavigatorState>(find.byType(Navigator));
    nav.push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => TaskFormCubit(mockTaskRepo, mockGoalRepo, task2),
          child: const TaskFormView(),
        ),
      ),
    );

    // This pumpAndSettle would throw if there's a Hero tag conflict during transition
    await tester.pumpAndSettle();

    expect(
      find.text('Edit Task'),
      findsWidgets,
    ); // Should find two versions of "Edit Task" in the tree (one obscured)
    // No assertion error thrown means fix works
  });

  testWidgets(
    'Pushing TaskDetailPage then GoalFormPage does not trigger Hero tag conflict',
    (tester) async {
      final task = Task(
        id: '1',
        title: 'Task 1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) =>
                          TaskFormCubit(mockTaskRepo, mockGoalRepo, task),
                      child: const TaskFormView(),
                    ),
                  ),
                ),
                child: const Text('Push Task'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Push Task'));
      await tester.pumpAndSettle();

      final nav = tester.state<NavigatorState>(find.byType(Navigator));
      nav.push(
        MaterialPageRoute(
          builder: (_) => GoalFormPage(
            goalRepo: mockGoalRepo,
            categoriesStream: Stream.value(Right(<GoalCategory>[])),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('New Goal'), findsOneWidget);
      // No assertion error thrown means fix works
    },
  );
}

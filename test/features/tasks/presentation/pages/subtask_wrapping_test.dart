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

    // Setup GetIt
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

  testWidgets('subtask text should wrap when it is too long', (tester) async {
    // 1. Render the TaskDetailPage in a "New Task" state
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // 2. Add a subtask
    await tester.tap(find.text('Add Sub Task'));
    await tester.pumpAndSettle();

    // 3. Find the subtask TextFormField
    // The first TextField is the title, the second is notes (if any),
    // but subtasks are in a list.
    // Let's use finding by hint text "Step 1"
    final subtaskField = find.widgetWithText(TextFormField, 'Step 1');
    expect(subtaskField, findsOneWidget);

    // 4. Measure initial height
    final double initialHeight = tester.getSize(subtaskField).height;

    // 5. Enter a very long string of text
    const longText =
        'This is a very long subtask title that should definitely wrap into multiple lines because it exceeds the standard width of a phone screen in most cases. It keeps going and going until it has no choice but to wrap. Here to add more text just to ensure this text indeed does wrap to the next line.';
    await tester.enterText(subtaskField, longText);
    await tester.pumpAndSettle();

    // 6. Measure new height
    final double newHeight = tester.getSize(subtaskField).height;

    // 7. Verify that the height has increased (wrapped)
    expect(
      newHeight,
      greaterThan(initialHeight),
      reason: 'The TextFormField height should increase when text wraps',
    );
  });
}

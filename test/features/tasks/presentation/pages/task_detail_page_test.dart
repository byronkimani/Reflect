import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/presentation/widgets/reflect_primary_button.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_state.dart';
import 'package:reflect/features/tasks/presentation/pages/task_detail_page.dart';

import '../../../../helpers/slidable_test_harness.dart';

class MockITaskRepository extends Mock implements ITaskRepository {}

class MockIGoalRepository extends Mock implements IGoalRepository {}

class MockTaskFormCubit extends MockCubit<TaskFormState>
    implements TaskFormCubit {}

void main() {
  late MockITaskRepository mockRepo;
  late MockIGoalRepository mockGoalRepo;
  final now = DateTime(2025, 3, 18, 12, 0);

  Task task({
    String id = 'task-1',
    String title = 'Existing task',
    List<Subtask> subtasks = const [],
    DateTime? dueDate,
    String? notes,
    String? goalId,
  }) => Task(
    id: id,
    title: title,
    priority: TaskPriority.p4,
    dueDate: dueDate ?? now,
    notes: notes,
    goalId: goalId,
    createdAt: now,
    updatedAt: now,
    subtasks: subtasks,
  );

  Subtask subtask({
    String id = 'sub-1',
    String title = 'Subtask one',
    bool isCompleted = false,
  }) => Subtask(
    id: id,
    taskId: 'task-1',
    title: title,
    isCompleted: isCompleted,
    sortOrder: 0,
    createdAt: now,
  );

  Widget buildTestWidget({String taskId = 'new', Task? initialTask}) {
    final navigatorKey = GlobalKey<NavigatorState>();
    final router = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: '/edit',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: SizedBox.shrink()),
          routes: [
            GoRoute(
              path: 'edit',
              builder: (_, _) => BlocProvider<TaskFormCubit>(
                create: (_) =>
                    TaskFormCubit(mockRepo, mockGoalRepo, initialTask),
                child: const TaskFormView(),
              ),
            ),
          ],
        ),
      ],
    );
    return SlidableAutoCloseBehavior(
      child: MaterialApp.router(routerConfig: router),
    );
  }

  setUp(() {
    mockRepo = MockITaskRepository();
    mockGoalRepo = MockIGoalRepository();
    when(
      () => mockGoalRepo.watchAllGoals(),
    ).thenAnswer((_) => Stream.value(const Right(<Goal>[])));
  });

  setUpAll(() {
    registerFallbackValue(
      Task(id: '', title: '', createdAt: now, updatedAt: now),
    );
  });

  Future<void> scrollForm(WidgetTester tester, {double delta = -280}) async {
    await tester.drag(
      find.byType(SingleChildScrollView).first,
      Offset(0, delta),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tapSaveButton(WidgetTester tester) async {
    final button = find.byType(ReflectPrimaryButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
  }

  Future<void> tapRepeatsRow(WidgetTester tester) async {
    await scrollForm(tester);
    await tester.ensureVisible(find.text('Repeats'));
    await tester.tap(find.text('Repeats'));
    await tester.pumpAndSettle();
  }

  Future<void> tapExtrasRow(WidgetTester tester) async {
    await scrollForm(tester);
    final row = find.ancestor(
      of: find.text('Notes, goal & tags'),
      matching: find.byType(ListTile),
    );
    await tester.ensureVisible(row);
    await tester.tap(row);
    await tester.pumpAndSettle();
  }

  Future<void> tapAddStep(WidgetTester tester) async {
    await scrollForm(tester);
    final button = find.widgetWithText(TextButton, 'Add step');
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  Finder extrasSheetNotesField() {
    return find.descendant(
      of: find.byType(BottomSheet),
      matching: find.byType(TextFormField),
    );
  }

  Future<void> tapExtrasSheetDone(WidgetTester tester) async {
    final doneButton = find.descendant(
      of: find.byType(BottomSheet),
      matching: find.widgetWithText(ReflectPrimaryButton, 'Done'),
    );
    await tester.ensureVisible(doneButton);
    await tester.tap(doneButton);
    await tester.pumpAndSettle();
  }

  Future<void> tapReminderSwitch(WidgetTester tester) async {
    final reminderSwitch = find.widgetWithText(
      SwitchListTile,
      'Remind me when due',
    );
    await tester.ensureVisible(reminderSwitch);
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(of: reminderSwitch, matching: find.byType(Switch)),
      warnIfMissed: false,
    );
    await tester.pumpAndSettle();
  }

  group('TaskDetailPage / TaskFormView', () {
    testWidgets('new task shows title "New Task" and empty form', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('New Task'), findsOneWidget);
      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('edit task shows title "Edit Task" and prefilled task title', (
      tester,
    ) async {
      final t = task(title: 'My existing task');
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      expect(find.text('Edit Task'), findsOneWidget);
      expect(find.text('My existing task'), findsOneWidget);
    });

    testWidgets('edit task with subtasks shows existing subtask titles', (
      tester,
    ) async {
      final sub1 = subtask(id: 's1', title: 'First step');
      final sub2 = subtask(id: 's2', title: 'Second step');
      final t = task(title: 'Task with steps', subtasks: [sub1, sub2]);
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      expect(find.text('First step'), findsOneWidget);
      expect(find.text('Second step'), findsOneWidget);
    });

    testWidgets('tap Save with empty title shows error', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tapSaveButton(tester);
      await tester.pumpAndSettle();

      expect(find.text('Title cannot be empty'), findsOneWidget);
    });

    testWidgets(
      'edit task: add subtask, tap Save, calls updateTask with new subtask',
      (tester) async {
        final t = task(
          id: 'task-1',
          title: 'Original',
          subtasks: [subtask(id: 's1', title: 'Existing')],
        );
        when(
          () => mockRepo.updateTask(any()),
        ).thenAnswer((inv) async => Right(inv.positionalArguments[0] as Task));
        await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
        await tester.pumpAndSettle();

        await tapAddStep(tester);
        final newSubtaskField = find.byType(TextFormField).last;
        await tester.ensureVisible(newSubtaskField);
        await tester.enterText(newSubtaskField, 'New step');
        await tester.pumpAndSettle();

        await tapSaveButton(tester);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        final captured = verify(
          () => mockRepo.updateTask(captureAny()),
        ).captured;
        expect(captured.length, 1);
        final updated = captured[0] as Task;
        expect(updated.subtasks.length, 2);
        expect(updated.subtasks.any((s) => s.title == 'Existing'), isTrue);
        expect(updated.subtasks.any((s) => s.title == 'New step'), isTrue);
      },
    );

    testWidgets(
      'edit task: change title and Save calls updateTask with new title',
      (tester) async {
        final t = task(id: 'task-1', title: 'Old title');
        when(
          () => mockRepo.updateTask(any()),
        ).thenAnswer((_) async => Right(t));
        await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byType(TextFormField).first,
          'Updated title',
        );
        await tester.pumpAndSettle();

        await tapSaveButton(tester);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        final captured = verify(
          () => mockRepo.updateTask(captureAny()),
        ).captured;
        expect((captured[0] as Task).title, 'Updated title');
      },
    );

    testWidgets('new task: enter title and Save calls createTask', (
      tester,
    ) async {
      when(
        () => mockRepo.createTask(any()),
      ).thenAnswer((_) async => Right(task()));
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).first,
        'New task title',
      );
      await tester.pumpAndSettle();

      await tapSaveButton(tester);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      verify(() => mockRepo.createTask(any())).called(1);
    });

    testWidgets(
      'after edit and save, re-opening form shows updated task with all subtasks',
      (tester) async {
        final sub1 = subtask(id: 's1', title: 'Step one');
        final t = task(id: 'task-1', title: 'Original title', subtasks: [sub1]);
        Task? capturedTask;
        when(() => mockRepo.updateTask(any())).thenAnswer((invocation) async {
          capturedTask = invocation.positionalArguments[0] as Task;
          return Right(capturedTask!);
        });
        await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byType(TextFormField).first,
          'Edited title',
        );
        await tester.pumpAndSettle();

        await tapAddStep(tester);

        final newSubtaskField = find.byType(TextFormField).last;
        await tester.ensureVisible(newSubtaskField);
        await tester.enterText(newSubtaskField, 'Step two');
        await tester.pumpAndSettle();

        await tapSaveButton(tester);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(capturedTask, isNotNull);
        expect(capturedTask!.title, 'Edited title');
        expect(capturedTask!.subtasks.length, 2);
        expect(
          capturedTask!.subtasks.any((s) => s.title == 'Step one'),
          isTrue,
        );
        expect(
          capturedTask!.subtasks.any((s) => s.title == 'Step two'),
          isTrue,
        );

        await tester.pumpWidget(
          buildTestWidget(taskId: capturedTask!.id, initialTask: capturedTask),
        );
        await tester.pumpAndSettle();

        expect(find.text('Edit Task'), findsOneWidget);
        expect(find.text('Edited title'), findsOneWidget);
        expect(find.text('Step one'), findsOneWidget);
        expect(find.text('Step two'), findsOneWidget);
      },
    );

    testWidgets('editing notes and saving passes notes to updateTask', (
      tester,
    ) async {
      final t = task(id: 'task-1', title: 'Task', notes: 'Old notes');
      when(() => mockRepo.updateTask(any())).thenAnswer((invocation) async {
        return Right(invocation.positionalArguments[0] as Task);
      });
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await tapExtrasRow(tester);

      await tester.enterText(extrasSheetNotesField(), 'New notes');
      await tester.pumpAndSettle();

      await tapExtrasSheetDone(tester);

      await tapSaveButton(tester);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final captured = verify(() => mockRepo.updateTask(captureAny())).captured;
      expect((captured[0] as Task).notes, 'New notes');
    });

    testWidgets('submitting on the last subtask adds a new subtask', (
      tester,
    ) async {
      final t = task(
        id: 'task-1',
        title: 'Task',
        subtasks: [subtask(id: 's1', title: 'Step 1')],
      );
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      var textFields = find.byType(TextFormField);
      final initialCount = textFields.evaluate().length;

      await tester.showKeyboard(textFields.last);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      textFields = find.byType(TextFormField);
      expect(textFields.evaluate().length, initialCount + 1);
    });

    testWidgets('tapping PriorityChip updates priority', (tester) async {
      final t = task(id: 'task-1', title: 'P1 task');
      when(() => mockRepo.updateTask(any())).thenAnswer((invocation) async {
        return Right(invocation.positionalArguments[0] as Task);
      });
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await tester.tap(find.text('P2'));
      await tester.pumpAndSettle();

      await tapSaveButton(tester);
      await tester.pumpAndSettle();

      final captured = verify(() => mockRepo.updateTask(captureAny())).captured;
      expect((captured[0] as Task).priority, TaskPriority.p2);
    });

    testWidgets('createTask failure shows error snackbar', (tester) async {
      when(() => mockRepo.createTask(any())).thenAnswer(
        (_) async => const Left(CacheFailure(errorMessage: 'Network error')),
      );
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'New task');
      await tester.pumpAndSettle();
      await tapSaveButton(tester);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Network error'), findsOneWidget);
    });

    testWidgets('updateTask failure shows error snackbar', (tester) async {
      final t = task(id: 'task-1', title: 'Task');
      when(() => mockRepo.updateTask(any())).thenAnswer(
        (_) async => const Left(CacheFailure(errorMessage: 'Save failed')),
      );
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'Changed title');
      await tester.pumpAndSettle();
      await tapSaveButton(tester);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Save failed'), findsOneWidget);
    });

    testWidgets('back with unsaved changes shows discard dialog', (
      tester,
    ) async {
      final t = task(id: 'task-1', title: 'Original');
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'Modified');
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.text('Discard changes?'), findsOneWidget);
      await tester.tap(find.text('Keep Editing'));
      await tester.pumpAndSettle();

      expect(find.text('Edit Task'), findsOneWidget);
    });

    testWidgets('discard dialog confirms navigation pop', (tester) async {
      final t = task(id: 'task-1', title: 'Original');
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'Modified');
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Discard'));
      await tester.pumpAndSettle();

      expect(find.text('Edit Task'), findsNothing);
    });

    testWidgets('Add to backlog calls updateTask with cleared due date', (
      tester,
    ) async {
      final t = task(
        id: 'task-1',
        title: 'Due today',
        dueDate: now,
      ).copyWith(dueTime: '09:00');
      when(() => mockRepo.updateTask(any())).thenAnswer(
        (invocation) async => Right(invocation.positionalArguments[0] as Task),
      );
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add to backlog'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final captured = verify(() => mockRepo.updateTask(captureAny())).captured;
      final updated = captured[0] as Task;
      expect(updated.dueDate, isNull);
      expect(updated.dueTime, isNull);
    });

    testWidgets('extras sheet Done button dismisses the sheet', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tapExtrasRow(tester);

      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.widgetWithText(ReflectPrimaryButton, 'Done'), findsOneWidget);

      await tapExtrasSheetDone(tester);

      expect(find.byType(BottomSheet), findsNothing);
    });

    testWidgets('extras sheet respects bottom safe area', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tapExtrasRow(tester);

      expect(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(SafeArea),
        ),
        findsOneWidget,
      );
    });

    testWidgets('shows goal selector in extras sheet when goals exist', (
      tester,
    ) async {
      when(() => mockGoalRepo.watchAllGoals()).thenAnswer(
        (_) => Stream.value(
          Right([
            Goal(
              id: 'goal-1',
              title: 'Run a marathon',
              timeHorizon: GoalTimeHorizon.yearly,
              createdAt: now,
              updatedAt: now,
            ),
          ]),
        ),
      );
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tapExtrasRow(tester);

      expect(extrasSheetNotesField(), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String?>), findsOneWidget);
      expect(find.text('Goal'), findsOneWidget);
    });

    testWidgets('toggling Repeats shows weekly recurrence controls', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tapRepeatsRow(tester);
      await scrollForm(tester);

      expect(find.text('Daily'), findsOneWidget);
      expect(find.text('Weekly'), findsOneWidget);

      await tester.tap(find.text('Weekly'));
      await tester.pumpAndSettle();

      expect(find.text('Weekdays'), findsOneWidget);
    });

    testWidgets('toggling reminder switch updates state', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final reminderSwitch = find.widgetWithText(
        SwitchListTile,
        'Remind me when due',
      );
      expect(tester.widget<SwitchListTile>(reminderSwitch).value, isFalse);

      await tapReminderSwitch(tester);

      expect(tester.widget<SwitchListTile>(reminderSwitch).value, isTrue);
    });

    testWidgets('tapping subtask checkbox toggles completion', (tester) async {
      final t = task(
        subtasks: [subtask(id: 's1', title: 'Step 1', isCompleted: false)],
      );
      when(() => mockRepo.updateTask(any())).thenAnswer(
        (invocation) async => Right(invocation.positionalArguments[0] as Task),
      );
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      final checkbox = find.byType(Checkbox);
      expect(tester.widget<Checkbox>(checkbox).value, isFalse);

      await tester.tap(checkbox);
      await tester.pumpAndSettle();

      expect(tester.widget<Checkbox>(checkbox).value, isTrue);
    });

    testWidgets('swiping subtask reveals delete action', (tester) async {
      final t = task(
        subtasks: [subtask(id: 's1', title: 'Remove me')],
      );
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Remove me'));
      await tester.pumpAndSettle();

      await SlidableTestHarness.openEndPane(
        tester,
        descendant: find.text('Remove me'),
      );

      expect(find.byType(SlidableAction), findsOneWidget);
    });

    testWidgets('deleting subtask via slidable removes the step', (
      tester,
    ) async {
      final t = task(
        subtasks: [subtask(id: 's1', title: 'Remove me')],
      );
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Remove me'));
      await tester.pumpAndSettle();

      await SlidableTestHarness.performEndAction(
        tester,
        descendant: find.text('Remove me'),
        icon: Icons.delete_outline,
      );

      final cubit = tester
          .element(find.byType(TaskFormView))
          .read<TaskFormCubit>();
      expect(cubit.state.subtaskItems, isEmpty);
    });

    testWidgets('submit with weekly recurrence includes recurrence rule', (
      tester,
    ) async {
      when(() => mockRepo.createTask(any())).thenAnswer(
        (invocation) async => Right(invocation.positionalArguments[0] as Task),
      );
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).first,
        'Weekly standup',
      );
      await tester.pumpAndSettle();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tapRepeatsRow(tester);
      await scrollForm(tester);
      await tester.tap(find.text('Weekly'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Weekdays'));
      await tester.pumpAndSettle();

      await tapSaveButton(tester);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final captured = verify(() => mockRepo.createTask(captureAny())).captured;
      final created = captured[0] as Task;
      expect(created.recurrenceRule?.frequency, RecurrenceFrequency.WEEKLY);
      expect(created.recurrenceRule?.daysOfWeek, isNotNull);
    });

    testWidgets('due date picker opens from pill', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await scrollForm(tester, delta: -200);
      await tester.ensureVisible(find.text('Pick date'));
      await tester.tap(find.text('Pick date'));
      await tester.pumpAndSettle();

      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('due time picker updates due time label', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await scrollForm(tester, delta: -350);
      await tester.ensureVisible(find.text('Add time'));
      await tester.tap(find.text('Add time'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Add time'), findsNothing);
    });

    testWidgets('weekly presets Every day and Weekend update recurrence', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tapRepeatsRow(tester);
      await scrollForm(tester);
      await tester.tap(find.text('Weekly'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Every day'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Weekend'));
      await tester.pumpAndSettle();
    });

    testWidgets('selects linked goal from dropdown', (tester) async {
      when(() => mockGoalRepo.watchAllGoals()).thenAnswer(
        (_) => Stream.value(
          Right([
            Goal(
              id: 'goal-1',
              title: 'Run marathon',
              timeHorizon: GoalTimeHorizon.yearly,
              createdAt: now,
              updatedAt: now,
            ),
          ]),
        ),
      );
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await scrollForm(tester);
      await tester.tap(find.text('Notes, goal & tags'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownButtonFormField<String?>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Run marathon').last);
      await tester.pumpAndSettle();
    });

    testWidgets('back without changes pops immediately', (tester) async {
      final t = task(id: 'task-1', title: 'Unchanged');
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.text('Edit Task'), findsNothing);
    });

    testWidgets('shows submitting indicator while save is in progress', (
      tester,
    ) async {
      when(() => mockRepo.createTask(any())).thenAnswer((inv) async {
        await Future<void>.delayed(const Duration(milliseconds: 300));
        return Right(inv.positionalArguments[0] as Task);
      });

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'Saving task');
      await tester.pumpAndSettle();
      await tapSaveButton(tester);
      await tester.pump();

      final button = tester.widget<ReflectPrimaryButton>(
        find.byType(ReflectPrimaryButton),
      );
      expect(button.isLoading, isTrue);

      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();
    });

    testWidgets('tapping Weekdays preset updates recurrence days', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tapRepeatsRow(tester);
      await scrollForm(tester);
      await tester.tap(find.text('Weekly'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Weekdays'));
      await tester.pumpAndSettle();

      expect(find.text('Weekdays'), findsWidgets);
    });

    testWidgets('due time picker opens from pill', (tester) async {
      final t = task(
        id: 'task-1',
        title: 'Timed task',
      ).copyWith(dueTime: '14:30');
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await scrollForm(tester, delta: -350);
      final timePill = find.byWidgetPredicate(
        (w) => w is Text && w.data != null && w.data!.contains(':'),
      );
      await tester.ensureVisible(timePill);
      await tester.tap(timePill);
      await tester.pumpAndSettle();

      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('PopScope intercepts route pop when form is modified', (
      tester,
    ) async {
      final t = task(id: 'task-1', title: 'Original');
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'Modified');
      await tester.pumpAndSettle();
      final scope = tester.widget<PopScope>(
        find.byWidgetPredicate((widget) => widget is PopScope),
      );
      scope.onPopInvokedWithResult!(false, null);
      await tester.pumpAndSettle();

      expect(find.text('Discard changes?'), findsOneWidget);
      await tester.tap(find.text('Discard'));
      await tester.pumpAndSettle();

      expect(find.text('Edit Task'), findsNothing);
    });

    testWidgets('tapping Today pill sets due date when not today', (
      tester,
    ) async {
      final t = task(dueDate: DateTime.now().add(const Duration(days: 3)));
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await scrollForm(tester);
      await tester.tap(find.text('Today'));
      await tester.pumpAndSettle();

      final cubit = tester
          .element(find.byType(TaskFormView))
          .read<TaskFormCubit>();
      final today = DateTime.now();
      expect(cubit.state.dueDate, DateTime(today.year, today.month, today.day));
    });

    testWidgets('tapping Tomorrow pill sets due date when not tomorrow', (
      tester,
    ) async {
      final t = task(dueDate: DateTime.now().add(const Duration(days: 3)));
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await scrollForm(tester);
      await tester.tap(find.text('Tomorrow'));
      await tester.pumpAndSettle();

      final cubit = tester
          .element(find.byType(TaskFormView))
          .read<TaskFormCubit>();
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      expect(
        cubit.state.dueDate,
        DateTime(tomorrow.year, tomorrow.month, tomorrow.day),
      );
    });

    testWidgets('tapping Today pill clears due date when already today', (
      tester,
    ) async {
      final today = DateTime.now();
      final t = task(dueDate: DateTime(today.year, today.month, today.day));
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await scrollForm(tester);
      await tester.tap(find.text('Today'));
      await tester.pumpAndSettle();

      final cubit = tester
          .element(find.byType(TaskFormView))
          .read<TaskFormCubit>();
      expect(cubit.state.dueDate, isNull);
    });

    testWidgets('tapping Tomorrow pill clears due date when already tomorrow', (
      tester,
    ) async {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      final t = task(
        dueDate: DateTime(tomorrow.year, tomorrow.month, tomorrow.day),
      );
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await scrollForm(tester);
      await tester.tap(find.text('Tomorrow'));
      await tester.pumpAndSettle();

      final cubit = tester
          .element(find.byType(TaskFormView))
          .read<TaskFormCubit>();
      expect(cubit.state.dueDate, isNull);
    });

    testWidgets('confirming date picker applies custom due date', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await scrollForm(tester, delta: -200);
      await tester.tap(find.text('Pick date'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pump();

      final cubit = tester
          .element(find.byType(TaskFormView))
          .read<TaskFormCubit>();
      expect(cubit.state.dueDate, isNotNull);
    });

    testWidgets('extras sheet nulls stale goal when linked goal is missing', (
      tester,
    ) async {
      when(() => mockGoalRepo.watchAllGoals()).thenAnswer(
        (_) => Stream.value(
          Right([
            Goal(
              id: 'goal-2',
              title: 'Other goal',
              timeHorizon: GoalTimeHorizon.weekly,
              createdAt: now,
              updatedAt: now,
            ),
          ]),
        ),
      );
      final t = task(goalId: 'deleted-goal');
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      await tapExtrasRow(tester);

      final dropdown = tester.widget<DropdownButtonFormField<String?>>(
        find.byType(DropdownButtonFormField<String?>),
      );
      expect(dropdown.initialValue, isNull);
    });

    testWidgets(
      'extras sheet defensive dropdown nulls stale selectedGoalId in cubit state',
      (tester) async {
        final mockCubit = MockTaskFormCubit();
        final staleState = TaskFormState(
          title: 'Existing task',
          availableGoals: [
            Goal(
              id: 'goal-2',
              title: 'Other goal',
              timeHorizon: GoalTimeHorizon.weekly,
              createdAt: now,
              updatedAt: now,
            ),
          ],
          selectedGoalId: 'deleted-goal',
        );
        when(() => mockCubit.state).thenReturn(staleState);
        when(
          () => mockCubit.stream,
        ).thenAnswer((_) => Stream.value(staleState));

        await tester.pumpWidget(
          SlidableAutoCloseBehavior(
            child: MaterialApp(
              home: Scaffold(
                body: BlocProvider<TaskFormCubit>.value(
                  value: mockCubit,
                  child: const TaskFormView(),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await scrollForm(tester);
        await tapExtrasRow(tester);

        final dropdown = tester.widget<DropdownButtonFormField<String?>>(
          find.byType(DropdownButtonFormField<String?>),
        );
        expect(dropdown.initialValue, isNull);
      },
    );

    testWidgets(
      'extras sheet dropdown preserves linked goal when selectedGoalId matches',
      (tester) async {
        final mockCubit = MockTaskFormCubit();
        final linkedState = TaskFormState(
          title: 'Existing task',
          availableGoals: [
            Goal(
              id: 'goal-1',
              title: 'Run marathon',
              timeHorizon: GoalTimeHorizon.yearly,
              createdAt: now,
              updatedAt: now,
            ),
          ],
          selectedGoalId: 'goal-1',
        );
        when(() => mockCubit.state).thenReturn(linkedState);
        when(
          () => mockCubit.stream,
        ).thenAnswer((_) => Stream.value(linkedState));

        await tester.pumpWidget(
          SlidableAutoCloseBehavior(
            child: MaterialApp(
              home: Scaffold(
                body: BlocProvider<TaskFormCubit>.value(
                  value: mockCubit,
                  child: const TaskFormView(),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await scrollForm(tester);
        await tapExtrasRow(tester);

        final dropdown = tester.widget<DropdownButtonFormField<String?>>(
          find.byType(DropdownButtonFormField<String?>),
        );
        expect(dropdown.initialValue, 'goal-1');
      },
    );
  });
}

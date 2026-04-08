import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_cubit.dart';

class MockITaskRepository extends Mock implements ITaskRepository {}

class MockIGoalRepository extends Mock implements IGoalRepository {}

void main() {
  late TaskFormCubit cubit;
  late MockITaskRepository mockRepo;
  late MockIGoalRepository mockGoalRepo;

  final now = DateTime(2025, 3, 18, 12, 0);

  setUpAll(() {
    final n = DateTime(2025, 3, 18, 12, 0);
    registerFallbackValue(Task(
      id: '',
      title: '',
      createdAt: n,
      updatedAt: n,
    ));
  });

  Task task({
    String id = 'task-1',
    String title = 'Existing task',
    List<Subtask> subtasks = const [],
    DateTime? dueDate,
    String? dueTime,
    TaskPriority priority = TaskPriority.p2,
    String? notes,
    bool hasEnabledReminder = false,
    RecurrenceRule? recurrenceRule,
    TaskStatus status = TaskStatus.pending,
  }) {
    final t = DateTime(2025, 3, 18);
    return Task(
      id: id,
      title: title,
      priority: priority,
      dueDate: dueDate ?? t,
      dueTime: dueTime,
      notes: notes,
      status: status,
      recurrenceRule: recurrenceRule,
      hasEnabledReminder: hasEnabledReminder,
      createdAt: now,
      updatedAt: now,
      subtasks: subtasks,
    );
  }

  Subtask subtask({
    String id = 'sub-1',
    String taskId = 'task-1',
    String title = 'Subtask',
    bool isCompleted = false,
    int sortOrder = 0,
  }) =>
      Subtask(
        id: id,
        taskId: taskId,
        title: title,
        isCompleted: isCompleted,
        sortOrder: sortOrder,
        createdAt: now,
      );

  setUp(() {
    mockRepo = MockITaskRepository();
    mockGoalRepo = MockIGoalRepository();
    when(() => mockGoalRepo.watchAllGoals()).thenAnswer(
      (_) => Stream.value(const Right(<Goal>[])),
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('TaskFormCubit initial state', () {
    test('initial state with null task has empty title and no subtasks', () {
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, null);
      expect(cubit.state.title, '');
      expect(cubit.state.subtaskItems, isEmpty);
      expect(cubit.state.initialTask, isNull);
      expect(cubit.state.dueDate, isNotNull);
    });

    test('initial state with task prefills title, notes, priority, dueDate', () {
      final t = task(
        title: 'Prefilled',
        notes: 'Some notes',
        priority: TaskPriority.p1,
        dueDate: DateTime(2025, 4, 1),
        dueTime: '10:30',
      );
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, t);
      expect(cubit.state.title, 'Prefilled');
      expect(cubit.state.notes, 'Some notes');
      expect(cubit.state.priority, TaskPriority.p1);
      expect(cubit.state.dueDate, DateTime(2025, 4, 1));
      expect(cubit.state.dueTime, '10:30');
      expect(cubit.state.initialTask, t);
    });

    test('initial state with task and subtasks maps subtasks to form items', () {
      final sub1 = subtask(id: 's1', title: 'First');
      final sub2 = subtask(id: 's2', title: 'Second', isCompleted: true);
      final t = task(subtasks: [sub1, sub2]);
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, t);
      expect(cubit.state.subtaskItems.length, 2);
      expect(cubit.state.subtaskItems[0].id, 's1');
      expect(cubit.state.subtaskItems[0].title, 'First');
      expect(cubit.state.subtaskItems[0].isCompleted, false);
      expect(cubit.state.subtaskItems[1].id, 's2');
      expect(cubit.state.subtaskItems[1].title, 'Second');
      expect(cubit.state.subtaskItems[1].isCompleted, true);
    });

    test('initial state with null task does not throw when building subtaskItems', () {
      expect(() => TaskFormCubit(mockRepo, mockGoalRepo, null), returnsNormally);
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, null);
      expect(cubit.state.subtaskItems, isEmpty);
    });
  });

  group('TaskFormCubit addSubtask', () {
    test('addSubtask appends a new item with empty title and not completed', () {
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, null);
      cubit.addSubtask();
      expect(cubit.state.subtaskItems.length, 1);
      expect(cubit.state.subtaskItems[0].title, '');
      expect(cubit.state.subtaskItems[0].isCompleted, false);
      expect(cubit.state.subtaskItems[0].id, isNotEmpty);
    });

    test('addSubtask with title appends item with that title', () {
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, null);
      cubit.addSubtask(' New step ');
      expect(cubit.state.subtaskItems.length, 1);
      expect(cubit.state.subtaskItems[0].title, 'New step');
    });

    test('addSubtask multiple times grows list', () {
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, null);
      cubit.addSubtask();
      cubit.addSubtask();
      cubit.addSubtask('Third');
      expect(cubit.state.subtaskItems.length, 3);
      expect(cubit.state.subtaskItems[2].title, 'Third');
    });

    test('addSubtask when editing task with existing subtasks appends after them', () {
      final sub = subtask(id: 's1', title: 'Existing');
      final t = task(subtasks: [sub]);
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, t);
      cubit.addSubtask('New one');
      expect(cubit.state.subtaskItems.length, 2);
      expect(cubit.state.subtaskItems[0].title, 'Existing');
      expect(cubit.state.subtaskItems[1].title, 'New one');
    });
  });

  group('TaskFormCubit removeSubtaskAt', () {
    test('removeSubtaskAt removes item at index', () {
      final t = task(subtasks: [
        subtask(id: 's1', title: 'A'),
        subtask(id: 's2', title: 'B'),
        subtask(id: 's3', title: 'C'),
      ]);
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, t);
      cubit.removeSubtaskAt(1);
      expect(cubit.state.subtaskItems.length, 2);
      expect(cubit.state.subtaskItems[0].title, 'A');
      expect(cubit.state.subtaskItems[1].title, 'C');
    });

    test('removeSubtaskAt with invalid index does nothing', () {
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, task(subtasks: [subtask(id: 's1', title: 'Only')]));
      cubit.removeSubtaskAt(-1);
      expect(cubit.state.subtaskItems.length, 1);
      cubit.removeSubtaskAt(5);
      expect(cubit.state.subtaskItems.length, 1);
    });
  });

  group('TaskFormCubit updateSubtaskAt and toggleSubtaskCompletedAt', () {
    test('updateSubtaskAt updates title at index', () {
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, task(subtasks: [subtask(id: 's1', title: 'Old')]));
      cubit.updateSubtaskAt(0, ' Updated ');
      expect(cubit.state.subtaskItems[0].title, 'Updated');
    });

    test('toggleSubtaskCompletedAt flips isCompleted and moves to bottom, then saves silently', () async {
      final t = task(
        id: 'task-1',
        title: 'T',
        subtasks: [
          subtask(id: 's1', title: 'A', isCompleted: false),
          subtask(id: 's2', title: 'B', isCompleted: false),
          subtask(id: 's3', title: 'C', isCompleted: false),
        ],
      );
      when(() => mockRepo.updateTask(any())).thenAnswer((_) async => Right(t));
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, t);
      
      expect(cubit.state.subtaskItems[0].isCompleted, false);
      cubit.toggleSubtaskCompletedAt(0);

      // 'A' should move to the bottom, pushing 'B' and 'C' up
      expect(cubit.state.subtaskItems.length, 3);
      expect(cubit.state.subtaskItems[0].title, 'B');
      expect(cubit.state.subtaskItems[1].title, 'C');
      expect(cubit.state.subtaskItems[2].title, 'A');
      expect(cubit.state.subtaskItems[2].isCompleted, true);
      
      // Auto-save silently should've triggered updateTask
      await Future.delayed(Duration.zero);
      final captured = verify(() => mockRepo.updateTask(captureAny())).captured;
      expect(captured.length, 1);
      final updatedTask = captured[0] as Task;
      expect(updatedTask.subtasks[2].title, 'A');
      expect(updatedTask.subtasks[2].isCompleted, true);

      // Unchecking 'A' should move it back up to the pending list (bottom of pending, top of completed)
      // Since everyone was pending, 'B' and 'C' are pending, 'A' will be added back at the end of pending
      cubit.toggleSubtaskCompletedAt(2);
      expect(cubit.state.subtaskItems[0].title, 'B');
      expect(cubit.state.subtaskItems[1].title, 'C');
      expect(cubit.state.subtaskItems[2].title, 'A');
      expect(cubit.state.subtaskItems[2].isCompleted, false);
    });
  });

  group('TaskFormCubit submit', () {
    test('submit with empty title sets error and does not call repository', () async {
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, null);
      await cubit.submit();
      expect(cubit.state.error, 'Title cannot be empty');
      verifyNever(() => mockRepo.createTask(any()));
      verifyNever(() => mockRepo.updateTask(any()));
    });

    test('submit new task calls createTask with task including subtasks', () async {
      when(() => mockRepo.createTask(any())).thenAnswer((_) async => Right(task()));
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, null);
      cubit.titleChanged('New task');
      cubit.addSubtask('Step 1');
      cubit.addSubtask('Step 2');
      await cubit.submit();

      final captured = verify(() => mockRepo.createTask(captureAny())).captured;
      expect(captured.length, 1);
      final created = captured[0] as Task;
      expect(created.title, 'New task');
      expect(created.subtasks.length, 2);
      expect(created.subtasks[0].title, 'Step 1');
      expect(created.subtasks[1].title, 'Step 2');
      expect(created.id, isNotEmpty);
    });

    test('submit edit with added subtasks calls updateTask with all subtasks', () async {
      final existingSub = subtask(id: 'existing-sub', taskId: 'task-1', title: 'Existing step');
      final t = task(id: 'task-1', title: 'Edit me', subtasks: [existingSub]);
      when(() => mockRepo.updateTask(any())).thenAnswer((_) async => Right(t));
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, t);
      cubit.addSubtask('New step');
      await cubit.submit();

      final captured = verify(() => mockRepo.updateTask(captureAny())).captured;
      expect(captured.length, 1);
      final updated = captured[0] as Task;
      expect(updated.id, 'task-1');
      expect(updated.title, 'Edit me');
      expect(updated.subtasks.length, 2);
      expect(updated.subtasks.any((s) => s.title == 'Existing step'), isTrue);
      expect(updated.subtasks.any((s) => s.title == 'New step'), isTrue);
      expect(updated.subtasks.every((s) => s.taskId == 'task-1'), isTrue);
    });

    test('submit edit with removed subtask calls updateTask with remaining subtasks', () async {
      final sub1 = subtask(id: 's1', title: 'Keep');
      final sub2 = subtask(id: 's2', title: 'Remove');
      final t = task(id: 'task-1', title: 'Edit', subtasks: [sub1, sub2]);
      when(() => mockRepo.updateTask(any())).thenAnswer((_) async => Right(t));
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, t);
      cubit.removeSubtaskAt(1);
      await cubit.submit();

      final captured = verify(() => mockRepo.updateTask(captureAny())).captured;
      expect(captured.length, 1);
      final updated = captured[0] as Task;
      expect(updated.subtasks.length, 1);
      expect(updated.subtasks.single.title, 'Keep');
    });

    test('submit edit preserves task status and other fields', () async {
      final t = task(
        id: 'task-1',
        title: 'Completed task',
        status: TaskStatus.completed,
        notes: 'Notes',
        priority: TaskPriority.p1,
      );
      when(() => mockRepo.updateTask(any())).thenAnswer((_) async => Right(t));
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, t);
      cubit.titleChanged('Updated title');
      await cubit.submit();

      final captured = verify(() => mockRepo.updateTask(captureAny())).captured;
      final updated = captured[0] as Task;
      expect(updated.status, TaskStatus.completed);
      expect(updated.title, 'Updated title');
      expect(updated.notes, 'Notes');
      expect(updated.priority, TaskPriority.p1);
    });

    test('submit filters out empty-title subtasks', () async {
      when(() => mockRepo.createTask(any())).thenAnswer((_) async => Right(task()));
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, null);
      cubit.titleChanged('Task');
      cubit.addSubtask('Valid');
      cubit.addSubtask('');
      cubit.addSubtask('   ');
      await cubit.submit();

      final captured = verify(() => mockRepo.createTask(captureAny())).captured;
      final created = captured[0] as Task;
      expect(created.subtasks.length, 1);
      expect(created.subtasks.single.title, 'Valid');
    });

    test('submit update failure sets error', () async {
      when(() => mockRepo.updateTask(any())).thenAnswer((_) async => Left(const CacheFailure(errorMessage: 'DB error')));
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, task(id: 'task-1', title: 'T'));
      await cubit.submit();
      expect(cubit.state.error, 'DB error');
      expect(cubit.state.isSubmitting, false);
    });

    test('submit edit with notes and dueDate change passes all to updateTask', () async {
      final newDate = DateTime(2025, 4, 20);
      final t = task(id: 'task-1', title: 'T', notes: 'Old', dueDate: DateTime(2025, 3, 18));
      when(() => mockRepo.updateTask(any())).thenAnswer((invocation) async => Right(invocation.positionalArguments[0] as Task));
      cubit = TaskFormCubit(mockRepo, mockGoalRepo, t);
      cubit.notesChanged('New notes');
      cubit.dueDateChanged(newDate);
      await cubit.submit();

      final captured = verify(() => mockRepo.updateTask(captureAny())).captured;
      final updated = captured[0] as Task;
      expect(updated.notes, 'New notes');
      expect(updated.dueDate, newDate);
    });
  });
}

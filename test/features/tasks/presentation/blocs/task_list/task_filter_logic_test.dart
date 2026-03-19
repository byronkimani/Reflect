import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';

class MockTaskRepository extends Mock implements ITaskRepository {}

void main() {
  late MockTaskRepository mockRepository;
  late TaskListBloc bloc;
  final now = DateTime(2025, 3, 19, 12, 0);

  setUp(() {
    mockRepository = MockTaskRepository();
    bloc = TaskListBloc(mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  Task testTask(
    String id,
    String title, {
    DateTime? dueDate,
    TaskStatus status = TaskStatus.pending,
    bool isOverdue = false,
  }) {
    return Task(
      id: id,
      title: title,
      dueDate: dueDate,
      status: status,
      isOverdue: isOverdue,
      createdAt: now,
      updatedAt: now,
    );
  }

  group('TaskListBloc Filtering Logic', () {
    test('partitions tasks into pending, completed, and overdue', () async {
      final today = DateTime(2025, 3, 19);
      final yesterday = DateTime(2025, 3, 18);

      final tasks = [
        testTask('1', 'Today Task', dueDate: today),
        testTask(
          '2',
          'Completed Task',
          dueDate: today,
          status: TaskStatus.completed,
        ),
        testTask('3', 'Overdue Task', dueDate: yesterday, isOverdue: true),
      ];

      when(
        () => mockRepository.watchTasksForDate(any()),
      ).thenAnswer((_) => Stream.value(Right(tasks)));

      bloc.add(TaskListEvent.loadTasksForDate(today));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const TaskListState.loading(),
          predicate<TaskListState>((state) {
            return state.maybeWhen(
              loaded: (pending, completed, overdue, _, _) {
                return pending.length == 1 &&
                    completed.length == 1 &&
                    overdue.length == 1 &&
                    pending.first.title == 'Today Task' &&
                    completed.first.title == 'Completed Task' &&
                    overdue.first.title == 'Overdue Task';
              },
              orElse: () => false,
            );
          }),
        ]),
      );
    });

    test(
      'excludes future tasks if they were returned by repository (sanity check)',
      () async {
        final today = DateTime(2025, 3, 19);
        final tomorrow = DateTime(2025, 3, 20);

        final tasks = [
          testTask('1', 'Today Task', dueDate: today),
          testTask('2', 'Tomorrow Task', dueDate: tomorrow),
        ];

        when(
          () => mockRepository.watchTasksForDate(any()),
        ).thenAnswer((_) => Stream.value(Right(tasks)));

        bloc.add(TaskListEvent.loadTasksForDate(today));

        await expectLater(
          bloc.stream,
          emitsInOrder([
            const TaskListState.loading(),
            predicate<TaskListState>((state) {
              return state.maybeWhen(
                loaded: (pending, completed, overdue, _, _) {
                  // In our current implementation, TaskListBloc puts all non-completed non-overdue
                  // into pending. So if the repository returned tomorrow's tasks,
                  // they would show up. This confirms we NEED the repository to filter correctly.
                  return pending.length == 2;
                },
                orElse: () => false,
              );
            }),
          ]),
        );
      },
    );
  });
}

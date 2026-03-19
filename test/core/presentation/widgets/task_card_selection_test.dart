import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';
import 'package:reflect/core/presentation/widgets/task_card.dart';

class MockTaskSelectionCubit extends Mock implements TaskSelectionCubit {}

void main() {
  late MockTaskSelectionCubit mockSelectionCubit;

  setUp(() {
    mockSelectionCubit = MockTaskSelectionCubit();
    // Default initial state
    when(() => mockSelectionCubit.state).thenReturn(const TaskSelectionState());
    when(() => mockSelectionCubit.close()).thenAnswer((_) => Future<void>.value());
    when(() => mockSelectionCubit.toggleSelection(any())).thenReturn(null);
    when(() => mockSelectionCubit.enterSelectionMode(any())).thenReturn(null);
    when(() => mockSelectionCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  tearDown(() {
    // No need to close mock explicitly if it causes issues, but let's try with proper stub
  });

  Task testTask({String id = '1', String title = 'Task 1'}) {
    return Task(
      id: id,
      title: title,
      priority: TaskPriority.p4,
      status: TaskStatus.pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Widget buildTestWidget(Task task) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<TaskSelectionCubit>.value(
          value: mockSelectionCubit,
          child: TaskCard(task: task),
        ),
      ),
    );
  }

  group('TaskCard Selection', () {
    testWidgets('toggles selection on tap when in selection mode', (WidgetTester tester) async {
      final task = testTask(id: '1');
      
      when(() => mockSelectionCubit.state).thenReturn(
        const TaskSelectionState(selectedTaskIds: {}, isSelectionMode: true),
      );

      await tester.pumpWidget(buildTestWidget(task));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Task 1'));
      await tester.pumpAndSettle();

      verify(() => mockSelectionCubit.toggleSelection('1')).called(1);
    });

    testWidgets('enters selection mode on long press', (WidgetTester tester) async {
      final task = testTask(id: '1');
      
      when(() => mockSelectionCubit.state).thenReturn(const TaskSelectionState());

      await tester.pumpWidget(buildTestWidget(task));
      await tester.pumpAndSettle();

      await tester.longPress(find.text('Task 1'));
      await tester.pumpAndSettle();

      verify(() => mockSelectionCubit.enterSelectionMode('1')).called(1);
    });
  });
}

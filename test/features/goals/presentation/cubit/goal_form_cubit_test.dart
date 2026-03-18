import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/goals/presentation/cubit/goal_form_cubit.dart';
import 'package:reflect/features/goals/presentation/cubit/goal_form_state.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

class MockIGoalRepository extends Mock implements IGoalRepository {}

void main() {
  late MockIGoalRepository mockRepo;
  final now = DateTime(2025, 3, 18, 12, 0);

  Goal goal({
    String id = 'goal-1',
    String title = 'Test goal',
    String? description,
    String? categoryId,
    GoalTimeHorizon timeHorizon = GoalTimeHorizon.weekly,
    TaskPriority? priority,
    TaskPriority? urgency,
    DateTime? startDate,
    DateTime? targetDate,
    CheckInFrequency? checkInFrequency,
  }) => Goal(
    id: id,
    title: title,
    description: description,
    categoryId: categoryId,
    timeHorizon: timeHorizon,
    priority: priority,
    urgency: urgency,
    startDate: startDate,
    targetDate: targetDate,
    checkInFrequency: checkInFrequency,
    createdAt: now,
    updatedAt: now,
  );

  setUp(() {
    mockRepo = MockIGoalRepository();
  });

  setUpAll(() {
    registerFallbackValue(
      Goal(
        id: '',
        title: '',
        timeHorizon: GoalTimeHorizon.weekly,
        createdAt: now,
        updatedAt: now,
      ),
    );
  });

  group('GoalFormCubit', () {
    test('initial state for new goal has empty title and weekly horizon', () {
      final cubit = GoalFormCubit(
        mockRepo,
        timeHorizon: GoalTimeHorizon.weekly,
      );
      expect(cubit.state.title, '');
      expect(cubit.state.timeHorizon, GoalTimeHorizon.weekly);
      expect(cubit.state.initialGoal, isNull);
      cubit.close();
    });

    test('initial state for new goal with monthly horizon', () {
      final cubit = GoalFormCubit(
        mockRepo,
        timeHorizon: GoalTimeHorizon.monthly,
      );
      expect(cubit.state.timeHorizon, GoalTimeHorizon.monthly);
      cubit.close();
    });

    test('initial state for edit goal prefills from initialGoal', () {
      final g = goal(
        title: 'Existing goal',
        description: 'Desc',
        categoryId: 'cat-1',
        priority: TaskPriority.p1,
        urgency: TaskPriority.p2,
      );
      final cubit = GoalFormCubit(mockRepo, initialGoal: g);
      expect(cubit.state.title, 'Existing goal');
      expect(cubit.state.description, 'Desc');
      expect(cubit.state.categoryId, 'cat-1');
      expect(cubit.state.priority, TaskPriority.p1);
      expect(cubit.state.urgency, TaskPriority.p2);
      expect(cubit.state.initialGoal, g);
      cubit.close();
    });

    blocTest<GoalFormCubit, GoalFormState>(
      'titleChanged updates title',
      build: () => GoalFormCubit(mockRepo),
      act: (cubit) => cubit.titleChanged('My goal'),
      expect: () => [predicate<GoalFormState>((s) => s.title == 'My goal')],
    );

    blocTest<GoalFormCubit, GoalFormState>(
      'descriptionChanged updates description',
      build: () => GoalFormCubit(mockRepo),
      act: (cubit) => cubit.descriptionChanged('A brief description'),
      expect: () => [
        predicate<GoalFormState>((s) => s.description == 'A brief description'),
      ],
    );

    blocTest<GoalFormCubit, GoalFormState>(
      'categoryIdChanged updates categoryId',
      build: () => GoalFormCubit(mockRepo),
      act: (cubit) => cubit.categoryIdChanged('cat-1'),
      expect: () => [predicate<GoalFormState>((s) => s.categoryId == 'cat-1')],
    );

    blocTest<GoalFormCubit, GoalFormState>(
      'priorityChanged updates priority',
      build: () => GoalFormCubit(mockRepo),
      act: (cubit) => cubit.priorityChanged(TaskPriority.p1),
      expect: () => [
        predicate<GoalFormState>((s) => s.priority == TaskPriority.p1),
      ],
    );

    blocTest<GoalFormCubit, GoalFormState>(
      'priorityChanged to null clears priority',
      build: () =>
          GoalFormCubit(mockRepo, initialGoal: goal(priority: TaskPriority.p1)),
      act: (cubit) => cubit.priorityChanged(null),
      expect: () => [
        predicate<GoalFormState>(
          (s) => s.priority == null && s.title == 'Test goal',
        ),
      ],
    );

    blocTest<GoalFormCubit, GoalFormState>(
      'urgencyChanged updates urgency',
      build: () => GoalFormCubit(mockRepo),
      act: (cubit) => cubit.urgencyChanged(TaskPriority.p3),
      expect: () => [
        predicate<GoalFormState>((s) => s.urgency == TaskPriority.p3),
      ],
    );

    blocTest<GoalFormCubit, GoalFormState>(
      'timeHorizonChanged updates timeHorizon',
      build: () => GoalFormCubit(mockRepo),
      act: (cubit) => cubit.timeHorizonChanged(GoalTimeHorizon.yearly),
      expect: () => [
        predicate<GoalFormState>(
          (s) => s.timeHorizon == GoalTimeHorizon.yearly,
        ),
      ],
    );

    blocTest<GoalFormCubit, GoalFormState>(
      'checkInFrequencyChanged updates checkInFrequency',
      build: () => GoalFormCubit(mockRepo),
      act: (cubit) => cubit.checkInFrequencyChanged(CheckInFrequency.weekly),
      expect: () => [
        predicate<GoalFormState>(
          (s) => s.checkInFrequency == CheckInFrequency.weekly,
        ),
      ],
    );

    blocTest<GoalFormCubit, GoalFormState>(
      'submit with empty title emits error',
      build: () => GoalFormCubit(mockRepo),
      act: (cubit) => cubit.submit(),
      expect: () => [
        predicate<GoalFormState>((s) => s.error == 'Title is required'),
      ],
    );

    blocTest<GoalFormCubit, GoalFormState>(
      'submit with whitespace-only title emits error',
      build: () => GoalFormCubit(mockRepo),
      act: (cubit) {
        cubit.titleChanged('   ');
        cubit.submit();
      },
      expect: () => [
        predicate<GoalFormState>((s) => s.title == '   '),
        predicate<GoalFormState>((s) => s.error == 'Title is required'),
      ],
    );

    blocTest<GoalFormCubit, GoalFormState>(
      'submit with valid title creates goal and emits success',
      build: () {
        when(
          () => mockRepo.createGoal(any()),
        ).thenAnswer((_) async => Right(goal(id: 'new-id', title: 'New goal')));
        return GoalFormCubit(mockRepo);
      },
      act: (cubit) async {
        cubit.titleChanged('New goal');
        await cubit.submit();
      },
      expect: () => [
        predicate<GoalFormState>((s) => s.title == 'New goal'),
        predicate<GoalFormState>((s) => s.isSubmitting == true),
        predicate<GoalFormState>(
          (s) => s.isSubmitting == false && s.isSuccess == true,
        ),
      ],
    );

    blocTest<GoalFormCubit, GoalFormState>(
      'submit create failure emits error',
      build: () {
        when(
          () => mockRepo.createGoal(any()),
        ).thenAnswer((_) async => Left(CacheFailure(errorMessage: 'DB error')));
        return GoalFormCubit(mockRepo);
      },
      act: (cubit) async {
        cubit.titleChanged('New goal');
        await cubit.submit();
      },
      expect: () => [
        predicate<GoalFormState>((s) => s.title == 'New goal'),
        predicate<GoalFormState>((s) => s.isSubmitting == true),
        predicate<GoalFormState>(
          (s) => s.isSubmitting == false && s.error == 'DB error',
        ),
      ],
    );

    blocTest<GoalFormCubit, GoalFormState>(
      'submit for edit calls updateGoal and emits success',
      build: () {
        final g = goal(id: 'existing', title: 'Existing');
        when(
          () => mockRepo.updateGoal(any()),
        ).thenAnswer((inv) async => Right(inv.positionalArguments[0] as Goal));
        return GoalFormCubit(mockRepo, initialGoal: g);
      },
      act: (cubit) async {
        cubit.titleChanged('Updated title');
        await cubit.submit();
      },
      expect: () => [
        predicate<GoalFormState>((s) => s.title == 'Updated title'),
        predicate<GoalFormState>((s) => s.isSubmitting == true),
        predicate<GoalFormState>(
          (s) => s.isSubmitting == false && s.isSuccess == true,
        ),
      ],
    );

    blocTest<GoalFormCubit, GoalFormState>(
      'optional fields trimmed to null when empty',
      build: () {
        when(() => mockRepo.createGoal(any())).thenAnswer((inv) async {
          final g = inv.positionalArguments[0] as Goal;
          expect(g.description, isNull);
          expect(g.kpiDescription, isNull);
          expect(g.startValue, isNull);
          expect(g.targetValue, isNull);
          expect(g.why, isNull);
          return Right(g);
        });
        return GoalFormCubit(mockRepo);
      },
      act: (cubit) async {
        cubit.titleChanged('Title');
        cubit.descriptionChanged('  ');
        cubit.kpiDescriptionChanged('');
        cubit.startValueChanged('   ');
        cubit.targetValueChanged('');
        cubit.whyChanged('');
        await cubit.submit();
      },
      expect: () => [
        predicate<GoalFormState>((s) => s.title == 'Title'),
        predicate<GoalFormState>((s) => s.description == '  '),
        predicate<GoalFormState>((s) => s.kpiDescription == ''),
        predicate<GoalFormState>((s) => s.startValue == '   '),
        predicate<GoalFormState>((s) => s.targetValue == ''),
        predicate<GoalFormState>((s) => s.why == ''),
        predicate<GoalFormState>((s) => s.isSubmitting == true),
        predicate<GoalFormState>((s) => s.isSuccess == true),
      ],
    );
  });
}

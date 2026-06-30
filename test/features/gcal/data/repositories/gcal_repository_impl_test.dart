import 'dart:convert';
import 'package:drift/drift.dart' hide Task;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/gcal/data/repositories/gcal_repository_impl.dart';
import 'package:reflect/features/gcal/data/sources/gcal_api_service.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

class MockGCalApiService extends Mock implements GCalApiService {}
class FakeTask extends Fake implements Task {}

void main() {
  late AppDatabase db;
  late MockGCalApiService mockApiService;
  late GCalRepositoryImpl repository;

  final tTask = Task(
    id: 'task1',
    title: 'Test Task',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  setUpAll(() {
    registerFallbackValue(FakeTask());
  });

  setUp(() async {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    mockApiService = MockGCalApiService();
    repository = GCalRepositoryImpl(db, mockApiService);

    await db.into(db.tasks).insert(TasksCompanion.insert(
      id: Value(tTask.id),
      title: tTask.title,
      createdAt: tTask.createdAt.millisecondsSinceEpoch,
      updatedAt: tTask.updatedAt!.millisecondsSinceEpoch,
      priority: 'medium',
    ));
  });

  tearDown(() async {
    await db.close();
  });

  group('GCalRepositoryImpl', () {
    test('pushEvent calls api service', () async {
      when(() => mockApiService.createEvent(any())).thenAnswer((_) async => const Right('gcal_1'));
      final result = await repository.pushEvent(tTask);
      expect(result, const Right('gcal_1'));
      verify(() => mockApiService.createEvent(tTask)).called(1);
    });

    test('updateEvent calls api service', () async {
      when(() => mockApiService.updateEvent(any())).thenAnswer((_) async => const Right(unit));
      final result = await repository.updateEvent(tTask);
      expect(result, const Right(unit));
      verify(() => mockApiService.updateEvent(tTask)).called(1);
    });

    group('processQueue', () {
      test('processes CREATE operation successfully', () async {
        await db.into(db.gCalSyncQueue).insert(GCalSyncQueueCompanion.insert(
          id: const Value('q1'),
          taskId: tTask.id,
          operation: 'CREATE',
          payload: jsonEncode(tTask.toJson()),
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ));
        
        when(() => mockApiService.createEvent(any())).thenAnswer((_) async => const Right('gcal_123'));

        final result = await repository.processQueue();

        expect(result.isRight(), isTrue);
        final queue = await db.select(db.gCalSyncQueue).get();
        expect(queue, isEmpty);

        final updatedTask = await (db.select(db.tasks)..where((t) => t.id.equals(tTask.id))).getSingle();
        expect(updatedTask.gcalEventId, 'gcal_123');
      });

      test('processes UPDATE operation successfully', () async {
        await db.into(db.gCalSyncQueue).insert(GCalSyncQueueCompanion.insert(
          id: const Value('q2'),
          taskId: tTask.id,
          operation: 'UPDATE',
          payload: jsonEncode(tTask.toJson()),
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ));
        when(() => mockApiService.updateEvent(any())).thenAnswer((_) async => const Right(unit));

        final result = await repository.processQueue();

        expect(result.isRight(), isTrue);
        final queue = await db.select(db.gCalSyncQueue).get();
        expect(queue, isEmpty);
      });

      test('processes DELETE operation successfully', () async {
        final taskWithGcalId = tTask.copyWith(gcalEventId: 'gcal_1');
        await db.into(db.gCalSyncQueue).insert(GCalSyncQueueCompanion.insert(
          id: const Value('q3'),
          taskId: tTask.id,
          operation: 'DELETE',
          payload: jsonEncode(taskWithGcalId.toJson()),
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ));
        when(() => mockApiService.deleteEvent(any())).thenAnswer((_) async => const Right(unit));

        final result = await repository.processQueue();

        expect(result.isRight(), isTrue);
        final queue = await db.select(db.gCalSyncQueue).get();
        expect(queue, isEmpty);
        verify(() => mockApiService.deleteEvent('gcal_1')).called(1);
      });

      test('skips items with retryCount >= 3', () async {
        await db.into(db.gCalSyncQueue).insert(GCalSyncQueueCompanion.insert(
          id: const Value('q4'),
          taskId: tTask.id,
          operation: 'CREATE',
          payload: jsonEncode(tTask.toJson()),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          retryCount: const Value(3),
        ));

        final result = await repository.processQueue();

        expect(result.isRight(), isTrue);
        final queue = await db.select(db.gCalSyncQueue).get();
        expect(queue, isNotEmpty); // not deleted because skipped
        verifyNever(() => mockApiService.createEvent(any()));
      });
    });

    test('watchQueueDepth returns stream of queue lengths', () async {
      final stream = repository.watchQueueDepth();
      expectLater(stream, emitsInOrder([0, 1]));

      await db.into(db.gCalSyncQueue).insert(GCalSyncQueueCompanion.insert(
        id: const Value('q5'),
        taskId: tTask.id,
        operation: 'CREATE',
        payload: '{}',
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ));
    });
  });
}

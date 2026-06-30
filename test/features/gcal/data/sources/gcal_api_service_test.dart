import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/gcal/data/sources/gcal_api_service.dart';

void main() {
  late GCalApiServiceImpl service;

  setUp(() {
    service = GCalApiServiceImpl();
  });

  group('GCalApiServiceImpl', () {
    final task = Task(
      id: '1',
      title: 'Test',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    test('createEvent returns placeholder id', () async {
      final result = await service.createEvent(task);
      expect(result.isRight(), isTrue);
      result.fold(
        (l) => fail('Should not fail'),
        (r) => expect(r, 'placeholder_gcal_id'),
      );
    });

    test('updateEvent returns unit', () async {
      final result = await service.updateEvent(task);
      expect(result.isRight(), isTrue);
      result.fold(
        (l) => fail('Should not fail'),
        (r) => expect(r, unit),
      );
    });

    test('deleteEvent returns unit', () async {
      final result = await service.deleteEvent('some-id');
      expect(result.isRight(), isTrue);
      result.fold(
        (l) => fail('Should not fail'),
        (r) => expect(r, unit),
      );
    });
  });
}

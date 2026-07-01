import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

@DataClassName('GCalSyncQueueData')
class GCalSyncQueue extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  /// Denormalized reference for debugging; not an FK so DELETE rows survive task removal.
  TextColumn get taskId => text()();
  TextColumn get operation => text()(); // CREATE, UPDATE, DELETE
  TextColumn get payload => text()(); // JSON payload
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal_category.freezed.dart';

@freezed
abstract class GoalCategory with _$GoalCategory {
  const factory GoalCategory({
    required String id,
    required String name,
    @Default(0) int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _GoalCategory;
}

import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String status;

  TaskModel({
    required this.title,
    required this.description,
    required this.category,
    required this.status,
  });

  // Add the copyWith method
  TaskModel copyWith({
    String? title,
    String? description,
    String? category,
    String? status,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
    );
  }
}

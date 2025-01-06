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
  late final String status;

  @HiveField(4)
  final int id; // Add an id field for uniqueness

  TaskModel({
    required this.title,
    required this.description,
    required this.category,
    this.status = 'Pending',
    required this.id, // Make sure to initialize the id
  });

  TaskModel copyWith({
    String? title,
    String? description,
    String? category,
    String? status,
    int? id, // Include id in the copyWith method
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
      id: id ?? this.id, // Copy the id
    );
  }
}

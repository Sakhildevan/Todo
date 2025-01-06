import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/task_model.dart';

class TaskController extends GetxController {
  final tasksBox = Hive.box<TaskModel>('tasks');
  var taskList = <TaskModel>[].obs;
  var filteredTasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    taskList.assignAll(tasksBox.values.toList());
    filteredTasks.assignAll(taskList);
  }

  void addTask(TaskModel task) {
    tasksBox.add(task);
    loadTasks();
  }

  void markAsComplete(TaskModel task) {
    final index = taskList.indexOf(task);
    final updatedTask = TaskModel(
      title: task.title,
      description: task.description,
      category: task.category,
      status: 'Completed',
    );
    tasksBox.putAt(index, updatedTask);
    loadTasks();
  }

  void deleteTask(TaskModel task) {
    final index = taskList.indexOf(task);
    tasksBox.deleteAt(index);
    loadTasks();
  }

  void searchTasks(String query) {
    if (query.isEmpty) {
      filteredTasks.assignAll(taskList);
    } else {
      filteredTasks.assignAll(taskList.where(
        (task) => task.title.toLowerCase().contains(query.toLowerCase()),
      ));
    }
  }

  void clearSearch() {
    filteredTasks.assignAll(taskList);
  }
}

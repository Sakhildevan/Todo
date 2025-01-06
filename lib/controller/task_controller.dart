import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/task_model.dart';

class TaskController extends GetxController {
  var taskList = <TaskModel>[].obs;
  var filteredTasks = <TaskModel>[].obs;
  late Box<TaskModel> taskBox;
  int _taskIdCounter = 0; // Counter for generating unique IDs

  @override
  void onInit() async {
    super.onInit();
    taskBox = await Hive.openBox<TaskModel>('tasks');
    loadTasks();
  }

  // Load tasks from Hive into taskList and filteredTasks
  void loadTasks() {
    final uniqueTasks = taskBox.values.toSet().toList(); // Remove duplicates
    taskList.value = uniqueTasks;
    filteredTasks.value = taskList;

    // Set the taskIdCounter based on the highest existing task ID
    if (taskList.isNotEmpty) {
      _taskIdCounter =
          taskList.map((task) => task.id).reduce((a, b) => a > b ? a : b);
    } else {
      _taskIdCounter = 0; // Initialize to 0 if the task list is empty
    }
  }

  // Method to generate a unique task ID
  int generateTaskId() {
    _taskIdCounter++; // Increment the counter first
    return _taskIdCounter; // Return the updated value
  }

  void addTask(TaskModel task) async {
    // Generate a unique ID for the new task
    print(taskList);
    print("---------------");
    final newTask = TaskModel(
      id: generateTaskId(), // Ensure the ID is unique
      title: task.title,
      description: task.description,
      category: task.category,
      status: task.status,
    );

    await taskBox.put(newTask.id, newTask); // Store in Hive using the unique ID
    taskList.add(newTask); // Add the new task to the list
    filteredTasks.add(newTask); // Update the filtered tasks
    print(taskList);
  }

  // Delete a task and remove it from Hive
  void deleteTask(TaskModel task) async {
    await taskBox.delete(task.id); // Delete from Hive using id as key
    taskList.remove(task);
    filteredTasks.remove(task);
  }

  // Mark a task as complete and update it in Hive
  void markAsComplete(TaskModel task) async {
    final updatedTask = task.copyWith(status: 'Completed');
    await taskBox.put(
        updatedTask.id, updatedTask); // Update in Hive using id as key
    taskList[taskList.indexOf(task)] = updatedTask;
    filteredTasks[filteredTasks.indexOf(task)] = updatedTask;
  }

  // Search tasks
  void searchTasks(String query) {
    if (query.isEmpty) {
      filteredTasks.value = taskList;
    } else {
      filteredTasks.value = taskList
          .where(
              (task) => task.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  // Clear search results
  void clearSearch() {
    filteredTasks.value = taskList;
  }
}

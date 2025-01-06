import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/utils/styles/app_colors.dart';

import '../controller/task_controller.dart';
import '../controller/theme_controller.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  final TaskController controller = Get.put(TaskController());
  final ThemeController themeController = Get.find();
  final TextEditingController searchController = TextEditingController();

  TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Task Management',
        ),
        actions: [
          IconButton(
            icon: Obx(() => Icon(
                  themeController.isDarkMode.value
                      ? Icons.light_mode
                      : Icons.dark_mode,
                )),
            onPressed: themeController.toggleTheme,
          ),
        ],
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Get.to(() => AddTaskScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Obx _body() {
    return Obx(() {
      if (controller.taskList.isEmpty) {
        return const Center(child: Text('No tasks found!'));
      }

      // Group tasks by category
      final groupedTasks = _groupTasksByCategory(controller.filteredTasks);

      // Calculate the task completion progress
      final totalTasks = controller.taskList.length;
      final completedTasks = controller.taskList
          .where((task) => task.status == 'Completed')
          .length;
      final progress = totalTasks == 0 ? 0.0 : completedTasks / totalTasks;

      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        child: Column(
          children: [
            //search bar
            _searchBar(),
            // Circular progress bar for task completion
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.primaryColor,
                  ),
                ),
                //circular progress
                child: _circularProgress(progress),
              ),
            ),
            // Task list grouped by categories
            _taskList(groupedTasks),
          ],
        ),
      );
    });
  }

  Expanded _taskList(Map<String, List<TaskModel>> groupedTasks) {
    return Expanded(
      child: ListView(
        children: groupedTasks.entries.map((entry) {
          return ExpansionTile(
            title: Text(entry.key), // Category name
            children: entry.value.map((task) {
              return TaskCard(task: task); // Display each task
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  Column _circularProgress(double progress) {
    return Column(
      children: [
        const Text('Task Completion Progress'),
        const SizedBox(height: 8),
        CircularProgressIndicator(
          color: AppColors.primaryColor,
          backgroundColor: AppColors.yellowColor,
          value: progress,
          strokeWidth: 8,
        ),
        const SizedBox(height: 8),
        Text('${(progress * 100).toStringAsFixed(0)}% completed'),
      ],
    );
  }

  Row _searchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Search tasks...',
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              controller.searchTasks(value);
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            searchController.clear();
            controller.clearSearch();
          },
        ),
      ],
    );
  }

  // Group tasks by category
  Map<String, List<TaskModel>> _groupTasksByCategory(List<TaskModel> tasks) {
    final Map<String, List<TaskModel>> groupedTasks = {};

    for (var task in tasks) {
      if (groupedTasks.containsKey(task.category)) {
        groupedTasks[task.category]?.add(task);
      } else {
        groupedTasks[task.category] = [task];
      }
    }

    return groupedTasks;
  }
}

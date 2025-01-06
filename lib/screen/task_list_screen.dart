import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/task_controller.dart';
import '../controller/theme_controller.dart';
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
      appBar: AppBar(
        title: const Text('Task Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearchDialog(context);
            },
          ),
          IconButton(
            icon: Obx(() => Icon(
                  themeController.isDarkMode.value
                      ? Icons.light_mode
                      : Icons.dark_mode,
                )),
            onPressed: themeController.toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.to(() => AddTaskScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.taskList.isEmpty) {
          return const Center(child: Text('No tasks found!'));
        }

        final categories = controller.filteredTasks
            .map((task) => task.category)
            .toSet()
            .toList();

        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final tasks = controller.filteredTasks
                .where((task) => task.category == category)
                .toList();

            return ExpansionTile(
              title: Text(category),
              children: tasks.map((task) => TaskCard(task: task)).toList(),
            );
          },
        );
      }),
    );
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Tasks'),
        content: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Enter task title',
            border: OutlineInputBorder(),
          ),
          onChanged: controller.searchTasks,
        ),
        actions: [
          TextButton(
            onPressed: () {
              searchController.clear();
              controller.clearSearch();
              Get.back();
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

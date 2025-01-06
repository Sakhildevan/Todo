import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todo/utils/styles/app_colors.dart';

import '../controller/task_controller.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final TaskController controller = Get.find();

  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: ValueKey(task.title),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            // Left slide action: Mark as Complete
            SlidableAction(
              onPressed: (context) {
                controller.markAsComplete(task);
              },
              backgroundColor: Colors.green,
              icon: Icons.check,
              label: 'Complete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            // Right slide action: Delete task
            SlidableAction(
              onPressed: (context) {
                _deleteTaskWithUndo(context);
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        // actionPane: SlidableDrawerActionPane(),
        child: ListTile(
          title: Text(task.title.toUpperCase()),
          subtitle: Text(
            task.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: SizedBox(
            width: 110,
            child: Chip(
              label: Text(
                task.status,
                style: const TextStyle(color: Colors.white), // Text color
              ),
              backgroundColor: task.status == 'Completed'
                  ? AppColors.greenColor
                  : AppColors.yellowColor,
            ),
          ),
        ));
  }

  void _deleteTaskWithUndo(BuildContext context) {
    // Save the task to a variable before deletion to allow undo
    final deletedTask = task;

    // Delete the task
    controller.deleteTask(task);

    // Show SnackBar with Undo option
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Task deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Undo the deletion by adding the task back
            controller.addTask(deletedTask);
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/task_controller.dart';
import '../models/task_model.dart';
import '../utils/widget/animated_button.dart';

class AddTaskScreen extends StatelessWidget {
  final TaskController controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final categories = ['Work', 'Personal', 'Other'];

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Task Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                items: categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  categoryController.text = value!;
                },
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black38,
                    )),
                child: TextFormField(
                  minLines: 5,
                  maxLines: 10,
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ),
              const SizedBox(height: 20),
              CustomAnimatedButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    final task = TaskModel(
                      id: 0, // Placeholder, the actual ID will be generated in TaskController
                      title: titleController.text,
                      description: descriptionController.text,
                      category: categoryController.text,
                      status: 'Pending', // Default status
                    );
                    controller.addTask(task); // Add task without ID
                    Get.back();
                  }
                },
                buttonWidth: 150,
                bgButtonColor: Colors.blue,
                text: 'Add Task',
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../task_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the main screen after a delay
    Timer(const Duration(seconds: 3), () {
      Get.off(() => TaskListScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/gif/gif.gif',
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

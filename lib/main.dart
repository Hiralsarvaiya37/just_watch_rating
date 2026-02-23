import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:just_watch_rating/features/api_post/job_details/view/job_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Salary Checker',
      debugShowCheckedModeBanner: false,
      home: JobDetailsScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:just_watch_rating/features/season/view/job_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      // home: HomeScreen(),
      // home: TvSeriesScreen(),
      home: JobScreen(),
    );
  }
}

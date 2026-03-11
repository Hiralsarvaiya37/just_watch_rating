import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:just_watch_rating/features/internet_connectivity/controller/internet_connectivity_controller.dart';

class InternetConnectivityScreen extends StatelessWidget {
  InternetConnectivityScreen({super.key});
  final InternetConnectivityController controller = Get.put(
    InternetConnectivityController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Internet Connectivity",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: Obx(() {
          return Card(
            color: Colors.black87,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                controller.status.value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_post/information/controller/information_controller.dart';

class InformationScreen extends StatelessWidget {
  InformationScreen({super.key});

  final InformationController controller = Get.put(InformationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Information", style: TextStyle(color: Colors.white)),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: controller.createPost,
        child: Icon(Icons.add),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.createData.value == null) {
          return Center(child: Text("No data found"));
        }

        final data = controller.createData.value!;
        return Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ID: ${data.id}"),
                  Text("Name: ${data.name}"),
                  Text("Color: ${data.data?.color}"),
                  Text("Capacity: ${data.data?.capacity}"),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

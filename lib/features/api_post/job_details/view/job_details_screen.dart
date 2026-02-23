import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_post/job_details/controller/job_details_controller.dart';

class JobDetailsScreen extends StatelessWidget {
  JobDetailsScreen({super.key});

  final controller = Get.put(JobDetailsController());

  final nameController = TextEditingController();
  final jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("POST API Example")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Enter Name"),
            ),
            TextField(
              controller: jobController,
              decoration: InputDecoration(labelText: "Enter Job"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.createUser(nameController.text, jobController.text);
              },
              child: Text("Create User"),
            ),
            SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading.value) {
                return CircularProgressIndicator();
              }

              if (controller.userData.value == null) {
                return Text("No Data");
              }

              final user = controller.userData.value!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${user.name}"),
                  Text("Job: ${user.job}"),
                  Text("ID: ${user.id}"),
                  Text("Created At: ${user.createdAt}"),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

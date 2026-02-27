import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:just_watch_rating/features/api_post/user_id/controller/user_details_id_controller.dart';

class UserDetailsIdScreen extends StatelessWidget {
  UserDetailsIdScreen({super.key});
  final UserDetailsIdController controller = Get.put(UserDetailsIdController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "User details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.userList.isEmpty) {
          return Center(child: Text("No data found"));
        }

        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: controller.userIdController,
                decoration: InputDecoration(
                  hintText: "User ID",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controller.bodyController,
                decoration: InputDecoration(
                  hintText: "Body",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  controller.addUser();
                },
                child: Text("Add data"),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.userList.length,
                  itemBuilder: (context, index) {
                    final user = controller.userList[index];
                    return Card(
                      child: ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("ID: ${user.id}"),
                            Text("User id: ${user.userId}"),
                            Text("Title: ${user.title}"),
                            Text("Body: ${user.body}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

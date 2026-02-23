import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_post/user_id/controller/user_details_controller.dart';

class UserDetailsScreen extends StatelessWidget {
  UserDetailsScreen({super.key});

  final UserDetailsController controller = Get.put(UserDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("User Data", style: TextStyle(color: Colors.white)),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.createPost("Flutter", "Learning POST API");
        },
        child: Icon(Icons.add, color: Colors.black, size: 25),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final user = controller.createdUser.value;

        if (user == null) {
          return Center(child: Text("No Data Found"));
        }

        return Center(
          child: Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ID: ${user.id}"),
                  Text("User ID: ${user.userId}"),
                  Text("Title: ${user.title}"),
                  Text("Body: ${user.body}"),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

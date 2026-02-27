import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:just_watch_rating/features/api_delete/post_info/controller/post_info_controller.dart';

class PostInfoScreen extends StatelessWidget {
  PostInfoScreen({super.key});
  final PostInfoController controller = Get.put(PostInfoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Delete API",
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
          return Center(child: Text("Data not found"));
        }

        return Padding(
          padding: EdgeInsets.all(16),
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
                      Text("User Id: ${user.userId}"),
                      Text("Title: ${user.title}"),
                      Text("Body: ${user.body}"),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      controller.deletePost(user.id);
                    },
                    icon: Icon(Icons.delete, size: 20),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:just_watch_rating/features/api_delete/user_delete/controller/user_delete_controller.dart';

class UserDeleteScreen extends StatelessWidget {
  UserDeleteScreen({super.key});
  final UserDeleteController controller = Get.put(UserDeleteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Demo API",
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
          return Center(child: Text("No found data"));
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
                      Text(
                        "ID: ${user.id}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("Post id: ${user.postId}"),
                      Text("Name: ${user.name}"),
                      Text("Email: ${user.email}"),
                      Text("Body: ${user.body}"),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      controller.delteData(user.id);
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

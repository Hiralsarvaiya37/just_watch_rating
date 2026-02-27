import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:just_watch_rating/features/api_patch/user_comments/controller/user_comments_controller.dart';

class UserCommentsScreen extends StatelessWidget {
  UserCommentsScreen({super.key});
  final UserCommentsController controller = Get.put(UserCommentsController());
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

        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.updatePost();
                  },
                  child: Text("Update data"),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.userList.length,
                  itemBuilder: (context, index) {
                    final user = controller.userList[index];
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ID: ${user.id}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Post Id: ${user.postId}"),
                            Text("Name: ${user.name}"),
                            Text("Email: ${user.email}"),
                            Text("Body: ${user.body}"),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            controller.nameController.text = user.name
                                .toString();
                            controller.selectedComment = user;
                            controller.selectedId.value = user.id;
                          },
                          icon: Icon(Icons.edit, size: 20),
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

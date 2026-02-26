import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:just_watch_rating/features/api_put/comments_data/controller/comments_data_controller.dart';

class CommentsDataScreen extends StatelessWidget {
  CommentsDataScreen({super.key});
  final CommentsDataController controller = Get.put(CommentsDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Comments",
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
                controller: controller.postIdController,
                decoration: InputDecoration(
                  hintText: "Post Id",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.updateComments();
                  },
                  child: Text("Update"),
                ),
              ),
              SizedBox(height: 20),
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
                            controller.selectedComment = user;
                            controller.postIdController.text = user.postId
                                .toString();
                            controller.titleController.text = user.name
                                .toString();
                            controller.selectedId.value = user.id;
                          },
                          icon: Icon(Icons.edit, size: 22, color: Colors.black),
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

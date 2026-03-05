import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/controller/api_demo_controller.dart';

class ApiDemoScreen extends StatelessWidget {
  ApiDemoScreen({super.key});
  final ApiDemoController controller = Get.put(ApiDemoController());
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
          return Center(child: Text("No data found"));
        }

        return Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller.postIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Post ID",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: controller.bodyController,
                decoration: InputDecoration(
                  hintText: "Body",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.selectedId.value == 0) {
                      controller.addUser();
                    } else {
                      controller.updateComments();
                    }
                  },
                  child: Text("Submit"),
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
                        subtitle: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ID: ${user.id}"),
                              Text("Post id: ${user.postId}"),
                              Text("Name: ${user.name}"),
                              Text("Email: ${user.email}"),
                              Text("Body: ${user.body}"),
                            ],
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.postIdController.text = user.postId
                                    .toString();
                                controller.nameController.text = user.name
                                    .toString();
                                controller.emailController.text = user.email
                                    .toString();
                                controller.bodyController.text = user.body
                                    .toString();
                                controller.selectedId.value = user.id;
                              },
                              icon: Icon(Icons.edit, size: 20),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.deleteUser(user.id);
                              },
                              icon: Icon(Icons.delete, size: 20),
                            ),
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

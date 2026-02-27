import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:just_watch_rating/features/api_patch/todos_details/controller/todos_details_controller.dart';

class TodosDetailsScreen extends StatelessWidget {
  TodosDetailsScreen({super.key});
  final TodosDetailsController controller = Get.put(TodosDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "API Patch demo",
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
                controller: controller.titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  controller.updateTodos();
                },
                child: Text("Update data"),
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
                            Text("Completed: ${user.completed}"),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            controller.selectedComment = user;
                            controller.selectedId.value = user.id;
                            controller.titleController.text = user.title
                                .toString();
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

import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:just_watch_rating/features/api_put/todos_data/controller/todos_data_controller.dart';

class TodosDataScreen extends StatelessWidget {
  TodosDataScreen({super.key});
  final TodosDataController controller = Get.put(TodosDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Todos",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller.userIdController,
                decoration: InputDecoration(
                  hintText: "User Id",
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
                    controller.updateTodos();
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
                      child: ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("ID: ${user.id}"),
                            Text("User Id: ${user.userId}"),
                            Text("Title: ${user.title}"),
                            Text("Completed: ${user.completed}"),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            controller.selectedComment = user;
                            controller.userIdController.text = user.userId
                                .toString();
                            controller.titleController.text = user.title
                                .toString();
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

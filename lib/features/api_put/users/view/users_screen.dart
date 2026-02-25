import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/users_controller.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({super.key});

  final controller = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: controller.nameController,
                    decoration: InputDecoration(labelText: "Name"),
                  ),

                  TextField(
                    controller: controller.ageController,
                    decoration: InputDecoration(labelText: "Age"),
                  ),

                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: controller.updateUser,
                    child: Text("Update User"),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: controller.usersList.length,
                itemBuilder: (context, index) {
                  final user = controller.usersList[index];

                  return Card(
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ID: ${user.id}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Name: ${user.firstName}"),
                          Text("Age: ${user.age}"),
                        ],
                      ),

                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          controller.editUser(user);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:just_watch_rating/features/api_put/user_information/controller/user_information_controller.dart';

class UserInformationScreen extends StatelessWidget {
  UserInformationScreen({super.key});
  final UserInformationController controller = Get.put(
    UserInformationController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "User Information",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller.idController,
                decoration: InputDecoration(
                  hintText: "Id",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.updateUser();
                  },
                  child: Text("Update Data"),
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
                            Text("ID: ${user.id}"),
                            Text("Name: ${user.name}"),
                            Text("Username: ${user.username}"),
                            Text("Email: ${user.email}"),
                            SizedBox(height: 12),
                            Text("------------ Address -------------"),
                            SizedBox(height: 5),
                            Text("Street: ${user.street}"),
                            Text("Suite: ${user.suite}"),
                            Text("City: ${user.city}"),
                            Text("Zipcode: ${user.zipcode}"),
                            Text("Lat: ${user.lat}"),
                            Text("Lng: ${user.lng}"),
                            Text("Phone: ${user.phone}"),
                            Text("Website: ${user.website}"),
                            SizedBox(height: 12),
                            Text("------------ Company -------------"),
                            SizedBox(height: 5),
                            Text("Companyname: ${user.companyName}"),
                            Text("Catchphrase: ${user.catchPhrase}"),
                            Text("Bs: ${user.bs}"),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            controller.selectedUser = user;
                            controller.idController.text = user.id.toString();
                            controller.titleController.text = user.name
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

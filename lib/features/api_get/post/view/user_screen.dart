import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_get/post/controller/user_controller.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Obx(() {
          return controller.isSearch.value
              ? TextField(
                  autofocus: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search by id...",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    controller.searchById(value);
                  },
                )
              : Text("User Data", style: TextStyle(color: Colors.white));
        }),
        actions: [
          IconButton(
            onPressed: () {
              controller.isSearch.toggle();

              if (!controller.isSearch.value) {
                controller.fetchUsers();
              }
            },
            icon: Obx(
              () => Icon(
                controller.isSearch.value ? Icons.close : Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: controller.userList.length,
            itemBuilder: (context, index) {
              var user = controller.userList[index];
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("User Id: ${user.userId}"),
                      Text("Id: ${user.id}"),
                      Text("Title: ${user.title}"),
                      Text("Body: ${user.body}"),
                    ],
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

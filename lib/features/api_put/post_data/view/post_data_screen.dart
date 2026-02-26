import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_put/post_data/controller/post_data_controller.dart';

class PostDataScreen extends StatelessWidget {
  PostDataScreen({super.key});
  final PostDataController controller = Get.put(PostDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Post",
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

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: controller.useridcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "User ID",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 10),

              TextField(
                controller: controller.titlecontroller,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 10),

              ElevatedButton(
                onPressed: controller.updateSelectedPost,
                child: Text("Update User"),
              ),

              SizedBox(height: 20),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
                          Text("User ID: ${user.userId}"),
                          Text("Title: ${user.title}"),
                          Text("Body: ${user.body}"),
                        ],
                      ),

                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          controller.selectPostForEdit(user);
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

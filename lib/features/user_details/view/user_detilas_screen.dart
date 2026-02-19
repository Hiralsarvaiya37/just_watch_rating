import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:just_watch_rating/features/user_details/controller/user_details_controller.dart';

class UserDetilasScreen extends StatelessWidget {
  UserDetilasScreen({super.key});
  final controller = Get.put(UserDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Obx(() {
          return controller.isSearching.value
              ? TextField(
                  cursorColor: Colors.greenAccent.shade700,
                  cursorWidth: 2,
                  autofocus: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search by id...",
                    hintStyle: TextStyle(color: Colors.white60),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    controller.searchById(value);
                  },
                )
              : Text(
                  "User details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                );
        }),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                controller.isSearching.toggle();
                if (!controller.isSearching.value) {
                  controller.fetchUser();
                }
              },
              icon: Icon(
                controller.isSearching.value ? Icons.close : Icons.search,
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
                      Text("ID: ${user.id}"),
                      Text("Name: ${user.name}"),
                      Text("Username: ${user.username}"),
                      Text("Email: ${user.email}"),
                      Text("Phone: ${user.phone}"),
                      Text("Website: ${user.website}"),
              
                      SizedBox(height: 8),
                      Text("---- Address ----"),
                      Text("Street: ${user.address.street}"),
                      Text("Suite: ${user.address.suite}"),
                      Text("City: ${user.address.city}"),
                      Text("Zipcode: ${user.address.zipcode}"),
                      Text("Lat: ${user.address.geo.lat}"),
                      Text("Lng: ${user.address.geo.lng}"),
              
                      SizedBox(height: 8),
                      Text("---- Company ----"),
                      Text("Company Name: ${user.company.name}"),
                      Text("Catch Phrase: ${user.company.catchPhrase}"),
                      Text("BS: ${user.company.bs}"),
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

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:just_watch_rating/features/api_get/service/controller/service_controller.dart';

class ServiceScreen extends StatelessWidget {
  ServiceScreen({super.key}) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.fetchDataPagination();
      }
    });
  }
  final ServiceController controller = Get.put(ServiceController());
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Obx(() {
          return controller.isSearching.value
              ? TextField(
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  cursorColor: Colors.greenAccent.shade700,
                  cursorWidth: 2,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 16),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    controller.searchId(value);
                  },
                )
              : Text(
                  "User information",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                );
        }),

        actions: [
          Obx(() {
            return IconButton(
              onPressed: () {
                controller.isSearching.toggle();
                if (!controller.isSearching.value) {
                  controller.fetchData();
                }
              },
              icon: Icon(
                controller.isSearching.value ? Icons.close : Icons.search,
                size: 25,
                color: Colors.white,
              ),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: EdgeInsets.all(12),
          child: ListView.builder(
            controller: scrollController,
            itemCount:
                controller.userList.length +
                (controller.isLoadingMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.userList.length) {
                var user = controller.userList[index];
                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Id: ${user.id}"),
                        Text("User id: ${user.userId}"),
                        Text("Title: ${user.title}"),
                      ],
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_get/todos/controller/todos_controller.dart';

class TodosScreen extends StatelessWidget {
  TodosScreen({super.key}) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.fetchDataPagination();
      }
    });
  }
  final TodosController controller = Get.put(TodosController());
  final ScrollController scrollController = ScrollController();

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
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    controller.searchById(value);
                  },
                )
              : Text(
                  "Todos",
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
                  controller.fetchData();
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

        if (controller.todosList.isEmpty) {
          return Center(child: Text("No todos found."));
        }

        return Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView.builder(
            controller: scrollController,
            itemCount:
                controller.todosList.length +
                (controller.isLoadingMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.todosList.length) {
                var todo = controller.todosList[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ID: ${todo.id}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("User ID: ${todo.userId}"),
                        Text("Title: ${todo.title}"),
                        Text("Completed: ${todo.completed ? "true" : "false"}"),
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

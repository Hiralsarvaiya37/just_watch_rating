import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_get/comments/controller/comments_controller.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key}) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.fetchDataPagination();
      }
    });
  }
  final CommentsController controller = Get.put(CommentsController());
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
                    hintText: "Search by id...",
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 16),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    controller.searchId(value);
                  },
                )
              : Text(
                  "Comments",
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
                size: 25,
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
            controller: scrollController,
            itemCount:
                controller.commentsList.length +
                (controller.isLoadingMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.commentsList.length) {
                var comment = controller.commentsList[index];
                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Id: ${comment.id}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text("Post id: ${comment.postId}"),
                        Text("Name: ${comment.name}"),
                        Text("Email: ${comment.email}"),
                        Text("Body: ${comment.body}"),
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

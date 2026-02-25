import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_put/post_data/model/post_data_model.dart';
import 'package:just_watch_rating/features/api_put/post_data/repository/post_data_repository.dart';

class PostDataController extends GetxController {
  final isLoading = false.obs;
  final userList = <PostDataModel>[].obs;
  final PostDataRepository repository = PostDataRepository();

  final useridcontroller = TextEditingController();
  final titlecontroller = TextEditingController();

  int? selectedPostId;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      var response = await repository.getData();
      userList.value = response;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  void selectPostForEdit(PostDataModel post) {
    selectedPostId = post.id;
    useridcontroller.text = post.userId.toString();
    titlecontroller.text = post.title;
  }

  Future<void> updateSelectedPost() async {
    if (selectedPostId == null) {
      Get.snackbar(
        "Error",
        "Please select a post to update",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading(true);

      final updatedPost = PostDataModel(
        id: selectedPostId!,
        userId: int.parse(useridcontroller.text),
        title: titlecontroller.text,
        body: userList
            .firstWhere((p) => p.id == selectedPostId!)
            .body, 
      );

      var updatedData = await repository.updateData(updatedPost);

      int index = userList.indexWhere((p) => p.id == updatedData.id);
      if (index != -1) {
        userList[index] = updatedData;
        userList.refresh();
      }

      selectedPostId = null;
      useridcontroller.clear();
      titlecontroller.clear();

      Get.snackbar(
        "Success",
        "Post updated successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}

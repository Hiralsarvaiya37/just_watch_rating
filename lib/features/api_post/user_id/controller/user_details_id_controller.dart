import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_post/user_id/model/user_details_id_model.dart';
import 'package:just_watch_rating/features/api_post/user_id/repository/user_details_id_repository.dart';

class UserDetailsIdController extends GetxController {
  final isLoading = false.obs;
  final userList = <UserDetailsIdModel>[].obs;
  final UserDetailsIdRepository repository = UserDetailsIdRepository();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      final response = await repository.getData();
      userList.value = response;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  Future<void> addUser() async {
    final newUser = UserDetailsIdModel(
      userId: int.tryParse(userIdController.text) ?? 0,
      id: userList.length + 1,
      title: titleController.text,
      body: bodyController.text,
    );

    try {
      isLoading(true);

      final response = await repository.postData(newUser);

      final newId = userList.isEmpty ? 1 : userList.last.id + 1;

      userList.add(
        UserDetailsIdModel(
          userId: response.userId,
          id: newId,
          title: response.title,
          body: response.body,
        ),
      );
      userIdController.clear();
      titleController.clear();
      bodyController.clear();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}

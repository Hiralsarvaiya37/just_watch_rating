import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_patch/user_comments/model/user_comments_model.dart';
import 'package:just_watch_rating/features/api_patch/user_comments/repository/user_comments_repository.dart';

class UserCommentsController extends GetxController {
  final isLoading = false.obs;
  final userList = <UserCommentsModel>[].obs;
  final UserCommentsRepository repository = UserCommentsRepository();
  TextEditingController nameController = TextEditingController();
  var selectedId = 0.obs;
  UserCommentsModel? selectedComment;

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

  Future<void> updatePost() async {
    try {
      isLoading(true);

      UserCommentsModel model = UserCommentsModel(
        postId: selectedComment!.postId,
        id: selectedComment!.id,
        name: nameController.text,
        email: selectedComment!.email,
        body: selectedComment!.body,
      );

      final update = await repository.updateData(model);

      int index = userList.indexWhere((e) => e.id == selectedId.value);
      if (index != -1) {
        userList[index] = update;
        userList.refresh();
      }
      nameController.clear();
      selectedId.value = 0;
      Get.snackbar(
        "Success",
        "Data update",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Update error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}

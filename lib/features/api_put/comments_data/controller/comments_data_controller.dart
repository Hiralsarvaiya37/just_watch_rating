import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_put/comments_data/model/comments_data_model.dart';
import 'package:just_watch_rating/features/api_put/comments_data/repository/comments_data_repository.dart';

class CommentsDataController extends GetxController {
  final isLoading = false.obs;
  final userList = <CommentsDataModel>[].obs;
  final CommentsDataRepository repository = CommentsDataRepository();
  TextEditingController postIdController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  CommentsDataModel? selectedComment;
  var selectedId = 0.obs;

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

  Future<void> updateComments() async {
    try {
      isLoading(true);

      CommentsDataModel model = CommentsDataModel(
        id: selectedId.value,
        postId: int.parse(postIdController.text),
        name: titleController.text,
        email: selectedComment!.email,
        body: selectedComment!.body,
      );

      final update = await repository.updateData(model);

      int index = userList.indexWhere((e) => e.id == selectedId.value);

      if (index != -1) {
        userList[index] = update;
        userList.refresh();
      }
      postIdController.clear();
      titleController.clear();
      selectedId.value = 0;
      Get.snackbar(
        "Success",
        "Comment Updated",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Update Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}

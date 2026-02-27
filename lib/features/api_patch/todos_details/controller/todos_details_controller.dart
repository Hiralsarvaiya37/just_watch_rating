import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_patch/todos_details/model/todos_details_model.dart';
import 'package:just_watch_rating/features/api_patch/todos_details/repository/todos_details_repository.dart';

class TodosDetailsController extends GetxController {
  final isLoading = false.obs;
  final userList = <TodosDetailsModel>[].obs;
  final TodosDetailsRepository repository = TodosDetailsRepository();
  TextEditingController titleController = TextEditingController();
  var selectedId = 0.obs;
  TodosDetailsModel? selectedComment;
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

  Future<void> updateTodos() async {
    try {
      isLoading(true);

      final model = TodosDetailsModel(
        userId: selectedComment!.userId,
        id: selectedId.value,
        title: titleController.text,
        completed: selectedComment!.completed,
      );
      final update = await repository.patchData(model);
      int index = userList.indexWhere((e) => e.id == selectedId.value);
      if (index != -1) {
        userList[index] = update;
        userList.refresh();
      }
      titleController.clear();
      selectedId.value = 0;
      Get.snackbar(
        "Success",
        "Data Updated",
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

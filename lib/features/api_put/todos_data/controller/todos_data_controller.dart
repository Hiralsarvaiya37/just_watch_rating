import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_put/todos_data/model/todos_data_model.dart';
import 'package:just_watch_rating/features/api_put/todos_data/repository/todos_data_repository.dart';

class TodosDataController extends GetxController {
  final isLoading = false.obs;
  final userList = <TodosDataModel>[].obs;
  TextEditingController userIdController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  var selectedId = 0.obs;
  TodosDataModel? selectedComment;
  final TodosDataRepository repository = TodosDataRepository();

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

      final model = TodosDataModel(
        userId: int.parse(userIdController.text),
        id: selectedId.value,
        title: titleController.text,
        completed: selectedComment!.completed,
      );
      final update = await repository.updateData(model);
      int index = userList.indexWhere((e) => e.id == selectedId.value);
      if (index != -1) {
        userList[index] = update;
        userList.refresh();
      }

      userIdController.clear();
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
        snackPosition: SnackPosition.BOTTOM
      );
    } finally {
      isLoading(false);
    }
  }
}

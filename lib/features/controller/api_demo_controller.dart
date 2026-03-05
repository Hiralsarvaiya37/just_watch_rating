import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/model/api_demo_model.dart';
import 'package:just_watch_rating/features/repository/api_demo_repository.dart';

class ApiDemoController extends GetxController {
  final isLoading = false.obs;
  final userList = <ApiDemoModel>[].obs;
  final postIdController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bodyController = TextEditingController();
  var selectedId = 0.obs;
  final ApiDemoRepository repository = ApiDemoRepository();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      final response = await repository.get();
      userList.value = response;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  Future<void> addUser() async {
    try {
      isLoading(true);
      final model = ApiDemoModel(
        postId: int.tryParse(postIdController.text) ?? 0,
        id: 0,
        name: nameController.text,
        email: emailController.text,
        body: bodyController.text,
      );
      final newUser = await repository.post(model);
      userList.add(newUser);
      Get.snackbar(
        "Success",
        "User added successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
      postIdController.clear();
      nameController.clear();
      emailController.clear();
      bodyController.clear();
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateComments() async {
    try {
      isLoading(true);

      ApiDemoModel model = ApiDemoModel(
        id: selectedId.value,
        postId: int.parse(postIdController.text),
        name: nameController.text,
        email: emailController.text,
        body: bodyController.text,
      );

      final update = await repository.update(model);

      int index = userList.indexWhere((e) => e.id == selectedId.value);

      if (index != -1) {
        userList[index] = update;
        userList.refresh();
      }
      postIdController.clear();
      nameController.clear();
      emailController.clear();
      bodyController.clear();
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

  Future<void> deleteUser(int id) async {
    try {
      isLoading(true);
      final success = await repository.delete(id);

      if (success) {
        userList.removeWhere((element) => element.id == id);
        Get.snackbar(
          "Success",
          "Comment deleted successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}

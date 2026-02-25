import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/users_model.dart';
import '../repository/users_repository.dart';

class UsersController extends GetxController {

  final repository = UsersRepository();

  var usersList = <UsersModel>[].obs;
  var isLoading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  UsersModel? selectedUser;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    isLoading.value = true;
    usersList.value = await repository.getUsers();
    isLoading.value = false;
  }

  void editUser(UsersModel user) {
    selectedUser = user;

    nameController.text = user.firstName ?? "";
    ageController.text = user.age.toString();
  }

  Future<void> updateUser() async {
    if (selectedUser == null) return;

    isLoading.value = true;

    final result = await repository.updateUser(
      id: selectedUser!.id!,
      firstName: nameController.text,
      age: int.parse(ageController.text),
    );

    if (result != null) {

      int index = usersList.indexWhere((e) => e.id == result.id);
      usersList[index] = result;
      usersList.refresh();

      Get.snackbar("Success", "User Updated",snackPosition: SnackPosition.BOTTOM);

      nameController.clear();
      ageController.clear();

      selectedUser = null;
    }

    isLoading.value = false;
  }
}
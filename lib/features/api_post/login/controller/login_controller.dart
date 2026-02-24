import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/login_model.dart';
import '../repository/login_repository.dart';

class LoginController extends GetxController {
  final LoginRepository repository = LoginRepository();

  var isLoading = false.obs;
  var userData = Rxn<LoginModel>();

  Future<void> login(String username, String password) async {
    try {
      if (username.trim().isEmpty || password.trim().isEmpty) {
        Get.snackbar("Error", "Valid username & Password",snackPosition: SnackPosition.BOTTOM);
        return;
      }

      isLoading.value = true;

      final data = await repository.loginUser(username, password);

      userData.value = LoginModel.fromJson(data);

      Get.snackbar(
        "Success",
        "Welcome ${userData.value?.firstName ?? ''}",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

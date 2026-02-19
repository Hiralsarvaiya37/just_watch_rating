import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/post/model/user_model.dart';

class UserController extends GetxController {
  var userList = <UserModel>[].obs;
  var isLoading = false.obs;
  var isSearch = false.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {

      isLoading(true);
      var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        userList.value = userListFromJson(response.body);
      } else {
        Get.snackbar(
          "Error",
          "Failed Status: ${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Network issue: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  List<UserModel> userListFromJson(String str) =>
      List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

  String userListToJson(List<UserModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  void searchById(String id) async {
    try {
      isLoading(true);

      var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts?id=$id"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var data = userListFromJson(response.body);

        if (data.isEmpty) {
          Get.snackbar(
            "Oops",
            "Data not found",
            snackPosition: SnackPosition.BOTTOM,
          );
          userList.clear();
        } else {
          userList.value = data;
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Network issue: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}

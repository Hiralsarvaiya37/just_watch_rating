import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_get/user_details/model/user_details_model.dart';
import 'package:just_watch_rating/features/api_get/user_details/repository/user_details_repository.dart';

class UserDetailsController extends GetxController {
  var userList = <UserDetailsModel>[].obs;
  var isLoading = false.obs;
  var isSearching = false.obs;

  final UserDetailsRepository repository = UserDetailsRepository();

  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  void fetchUser() async {
    try {
      isLoading(true);

      var data = await repository.getData();
      userList.value = data;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  void searchById(String id) async {
    try {
      isLoading(true);

      var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users?id=$id"),
        headers: {"Content-Type": "application/json"},
      );
      var data = userDetailsModelFromJson(response.body);
      if (response.statusCode == 200) {
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

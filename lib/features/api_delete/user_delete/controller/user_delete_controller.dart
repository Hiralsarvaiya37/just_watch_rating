import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_delete/user_delete/model/user_delete_model.dart';
import 'package:just_watch_rating/features/api_delete/user_delete/repository/user_delete_repository.dart';

class UserDeleteController extends GetxController {
  final isLoading = false.obs;
  final userList = <UserDeleteModel>[].obs;
  final UserDeleteRepository repository = UserDeleteRepository();

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

  Future<void> delteData(int id) async {
    try {
      await repository.deletePost(id);
      userList.removeWhere((e) => e.id == id);
      Get.snackbar(
        "Success",
        "Post Deleted",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}

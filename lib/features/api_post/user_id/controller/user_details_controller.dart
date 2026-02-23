import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_post/user_id/model/user_details_model.dart';
import 'package:just_watch_rating/features/api_post/user_id/repository/user_details_repository.dart';

class UserDetailsController extends GetxController {
  var isLoading = false.obs;
  var userList = <UserDetailsModel>[].obs;
  var createdUser = Rxn<UserDetailsModel>();

  final UserDetailsRepository repository = UserDetailsRepository();

  Future<void> createPost(String title, String body) async {
    try {
      isLoading(true);

      UserDetailsModel newPost = UserDetailsModel(
        userId: 1,
        id: 0,
        title: title,
        body: body,
      );
      final response = await repository.createPost(newPost);

      createdUser.value = response;

      Get.snackbar(
        "Success",
        "Post Created Successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}

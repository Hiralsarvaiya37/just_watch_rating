import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_get/comments/model/comments_model.dart';
import 'package:just_watch_rating/features/api_get/comments/repository/comments_reository.dart';

class CommentsController extends GetxController {
  var isSearching = false.obs;
  var isLoading = false.obs;
  var commentsList = <CommentsModel>[].obs;
  var isLoadingMore = false.obs;
  int page = 1;
  final int limit = 10;
  bool hasMore = true;

  final CommentsReository repository = CommentsReository();

  @override
  void onInit() {
    fetchDataPagination();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var data = await repository.getData(page, limit);
      commentsList.value = data;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  void searchId(String id) async {
    try {
      isLoading(true);

      var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/comments?id=$id"),
        headers: {"Content-Type": "application/json"},
      );
      var data = commentsModelFromJson(response.body);
      if (response.statusCode == 200) {
        if (data.isEmpty) {
          Get.snackbar(
            "Oops",
            "Data not found",
            snackPosition: SnackPosition.BOTTOM,
          );
          commentsList.clear();
        } else {
          commentsList.value = data;
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

  Future<void> fetchDataPagination() async {
    if (!hasMore || isLoadingMore.value) return;

    try {
      if (page == 1) {
        isLoading(true);
      } else {
        isLoadingMore(true);
      }

      var data = await repository.getData(page, limit);

      if (data.length < limit) {
        hasMore = false;
      }

      commentsList.addAll(data);
      page++;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
      isLoadingMore(false);
    }
  }
}

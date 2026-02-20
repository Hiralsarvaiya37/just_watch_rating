import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_get/todos/model/todos_model.dart';
import 'package:just_watch_rating/features/api_get/todos/repository/todos_repository.dart';

class TodosController extends GetxController {
  var todosList = <TodosModel>[].obs;
  var isLoading = false.obs;
  var isSearching = false.obs;
  var isLoadingMore = false.obs;
  int page = 1;
  final int limit = 10;
  bool hasMore = true;

  final TodosRepository repository = TodosRepository();

  @override
  void onInit() {
    fetchDataPagination();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var data = await repository.getData(page, limit);
      todosList.value = data;
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
        Uri.parse("https://jsonplaceholder.typicode.com/todos?id=$id"),
        headers: {"Content-Type": "application/json"},
      );
      var data = todosModelFromJson(response.body);
      if (response.statusCode == 200) {
        if (data.isEmpty) {
          Get.snackbar(
            "Oops",
            "Data not found",
            snackPosition: SnackPosition.BOTTOM,
          );
          todosList.clear();
        } else {
          todosList.value = data;
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
      todosList.addAll(data);
      page++;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
      isLoadingMore(false);
    }
  }
}

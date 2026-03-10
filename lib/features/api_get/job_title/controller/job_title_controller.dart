import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:just_watch_rating/features/api_get/job_title/model/job_title_model.dart';
import 'package:just_watch_rating/features/api_get/job_title/repository/job_title_repository.dart';

class JobTitleController extends GetxController {
  final isLoading = false.obs;
  final userList = <JobTitleModel>[].obs;
  final JobTitleRepository repository = JobTitleRepository();

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
}

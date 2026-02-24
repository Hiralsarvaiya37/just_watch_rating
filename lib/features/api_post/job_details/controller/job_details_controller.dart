import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_post/job_details/model/job_details_model.dart';
import 'package:just_watch_rating/features/api_post/job_details/repository/job_details_repository.dart';

class JobDetailsController extends GetxController {
  final isLoading = false.obs;
  final userData = Rxn<JobDetailsModel>();

  Future<void> createUser(String name, String job) async {
    try {
      isLoading(true);
      final model = JobDetailsModel(name: name, job: job);

      final data = await JobDetailsRepository().createUser(model);

      userData.value = data;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}

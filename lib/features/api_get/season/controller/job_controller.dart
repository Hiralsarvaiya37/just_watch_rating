import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_get/season/model/job_model.dart';
import 'package:just_watch_rating/features/api_get/season/repository/job_repository.dart';

class JobController extends GetxController {
  final JobRepository repo = JobRepository();

  var isSearchVisible = false.obs;
  var isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  var jobData = Rxn<JobModel>();

  @override
  void onInit() {
    fetchSalaryData();
    super.onInit();
  }

  Future<void> fetchSalaryData() async {
    try {
      isLoading.value = true;

      final result = await repo.getJobSalaryApi(
        searchText: searchController.text.trim().isEmpty
            ? "developer"
            : searchController.text.trim(),
        countryCode: "DE",
      );

      jobData.value = result;
    } catch (e) {

      String message = "Dtry again later.";
      if (e.toString().contains("429")) {
        message =
            "API limit cross ho gaya hai. Please try next month or upgrade plan.";
      }

      Get.snackbar(
        "Error",
        message,
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchSubmitted() {
    isSearchVisible.value = false;
    fetchSalaryData();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

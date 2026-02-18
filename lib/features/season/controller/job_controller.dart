import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/season/model/job_model.dart'; // ← apna model path
import 'package:just_watch_rating/features/season/repository/job_repository.dart';

class JobController extends GetxController {
  final JobRepository repo = JobRepository();

  var isSearchVisible = false.obs;
  var isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  var jobData = Rxn<JobModel>();

  @override
  void onInit() {
    super.onInit();
    fetchSalaryData();
  }

  Future<void> fetchSalaryData() async {
    try {
      isLoading.value = true;

      final searchText = searchController.text.trim().isEmpty
          ? "developer"
          : searchController.text.trim();

      final result = await repo.getJobSalaryApi(
        searchText: searchText,
        countryCode: "DE", 
      );

      jobData.value = result;

      print("Data loaded: ${jobData.value}");
    } catch (e) {
      print("API Error: $e");
      Get.snackbar(
        "Error",
        "Data nahi mila, please check internet or job title",
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
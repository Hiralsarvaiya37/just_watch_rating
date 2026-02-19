import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/season/controller/job_controller.dart';

class JobScreen extends StatelessWidget {
  JobScreen({super.key});

  final controller = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Obx(
          () => controller.isSearchVisible.value
              ? TextField(
                  controller: controller.searchController,
                  autofocus: true,
                  cursorColor: Colors.greenAccent.shade700,
                  style: const TextStyle(color: Colors.white),
                  onSubmitted: (_) => controller.onSearchSubmitted(),
                  decoration: const InputDecoration(
                    hintText: "Job title...",
                    hintStyle: TextStyle(color: Colors.white60),
                    border: InputBorder.none,
                  ),
                )
              : const Text(
                  "Salary Checker",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                if (controller.isSearchVisible.value) {
                  controller.isSearchVisible.value = false;
                  controller.onSearchSubmitted();
                } else {
                  controller.isSearchVisible.value = true;
                }
              },
              icon: Icon(
                controller.isSearchVisible.value ? Icons.close : Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.jobData.value;

        if (data == null) {
          return const Center(child: Text("No data"));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.country,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text("Code: ${data.countryCode}", style: const TextStyle(fontSize: 16)),
                  Text("Currency: ${data.currency}", style: const TextStyle(fontSize: 16)),
                  const Divider(height: 30),
                  Text(
                    "Monthly Salary Range",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue.shade800),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSalaryBox("Min", data.minMonthlySalary, data.currency),
                      buildSalaryBox("Max", data.maxMonthlySalary, data.currency),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildSalaryBox(String label, double value, String currency) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 6),
        Text(
          "${value.toStringAsFixed(0)} $currency",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
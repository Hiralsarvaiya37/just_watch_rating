import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivityController extends GetxController {
  var status = "Checking...".obs;
  late final Connectivity connectivity;

  @override
  void onInit() {
    super.onInit();
    connectivity = Connectivity();

    checkInternet();

    connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      if (results.isNotEmpty) {
        updateStatus(results.first);
      }
    });
  }

  void checkInternet() async {
    List<ConnectivityResult> results = await connectivity.checkConnectivity();
    if (results.isNotEmpty) {
      updateStatus(results.first);
    }
  }

  void updateStatus(ConnectivityResult result) {
    String newStatus;
    switch (result) {
      case ConnectivityResult.wifi:
        newStatus = "WiFi Connected";
        break;
      case ConnectivityResult.mobile:
        newStatus = "Mobile Data Connected";
        break;
      case ConnectivityResult.none:
        newStatus = "No Internet";
        break;
      default:
        newStatus = "Unknown";
        break;
    }
    status.value = newStatus;

    Get.snackbar(
      "Internet Status",
      newStatus,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
    );
  }
}

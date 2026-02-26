import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_put/user_information/model/user_information_model.dart';
import 'package:just_watch_rating/features/api_put/user_information/repository/user_information_repository.dart';

class UserInformationController extends GetxController {
  final isLoading = false.obs;
  final userList = <UserInformationModel>[].obs;
  final UserInformationRepository repository = UserInformationRepository();
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  var selectedId = 0.obs;
  UserInformationModel? selectedUser;

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

  Future<void> updateUser() async {
    try {
      isLoading(true);
      UserInformationModel model = UserInformationModel(
        id: int.parse(idController.text),
        name: titleController.text,
        username: selectedUser!.username,
        email: selectedUser!.email,
        street: selectedUser!.street,
        suite: selectedUser!.suite,
        city: selectedUser!.city,
        zipcode: selectedUser!.zipcode,
        lat: selectedUser!.lat,
        lng: selectedUser!.lng,
        phone: selectedUser!.phone,
        website: selectedUser!.website,
        companyName: selectedUser!.companyName,
        catchPhrase: selectedUser!.catchPhrase,
        bs: selectedUser!.bs,
      );

      final update = await repository.updateData(model);
      int index = userList.indexWhere((e) => e.id == selectedId.value);

      if (index != -1) {
        userList[index] = update;
        userList.refresh();
      }
      idController.clear();
      titleController.clear();
      selectedId.value = 0;
      Get.snackbar(
        "Successfully",
        "User updated",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Update Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}

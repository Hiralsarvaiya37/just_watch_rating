import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_post/information/model/information_model.dart';
import 'package:just_watch_rating/features/api_post/information/repository/information_repository.dart';

class InformationController extends GetxController {
  final repo = InformationRepository();

  var isLoading = false.obs;
  var createData = Rxn<InformationModel>();

  Future<void> createPost() async {
    try {
      isLoading(true);

      final model = InformationModel(
        name: "Google Pixel",
        data: Data(
          color: "Black",
          capacity: "128 GB",
        ),
      );

      final response = await repo.userInfo(model);

      createData.value = response;
    } catch (e) {
  Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
     
    } finally {
      isLoading(false);
    }
  }
}
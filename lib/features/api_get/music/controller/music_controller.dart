import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_get/music/model/music_model.dart';
import 'package:just_watch_rating/features/api_get/music/repository/music_repository.dart';

class MusicController extends GetxController {
  var isLoading = false.obs;
  var musicData = Rxn<MusicModel>();
  final MusicRepository repository = MusicRepository();
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);

      var data = await repository.getData();
      musicData.value = data;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
  
}

import 'package:get/get.dart';
import 'package:just_watch_rating/features/movie_management/model/tv_series_model.dart';
import 'package:just_watch_rating/utils/tv_series_helper.dart';

class TvSeriesController extends GetxController {
  var seriesList = <TvSeriesModel>[].obs;
  var filteredList = <TvSeriesModel>[].obs;
  var isSearching = false.obs;
  final helper = TvSeriesHelper();

  @override
  void onInit() {
    fetchSeries();
    super.onInit();
  }

  Future<void> fetchSeries({String? searchText}) async {
    seriesList.value = await helper.fetchSeries(searchText: searchText);
    filteredList.value = seriesList;
  }

    Future<void> getSeriesApi(String searchText) async {
   seriesList.value = await helper.fetchSeries(searchText: searchText);
  }

  void searchSeries(String query) {
    if (query.isEmpty) {
      filteredList.value = seriesList;
    } else {
      getSeriesApi(query);
      filteredList.value = seriesList
          .where(
            (item) => item.title.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }
}

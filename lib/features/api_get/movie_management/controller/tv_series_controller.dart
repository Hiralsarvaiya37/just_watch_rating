import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_get/movie_management/model/tv_series_model.dart';
import 'package:just_watch_rating/features/api_get/movie_management/repository/tv_series_repository.dart';

class TvSeriesController extends GetxController {
  var seriesList = <TvSeriesModel>[].obs;    
  var filteredList = <TvSeriesModel>[].obs;  
  var isSearching = false.obs;
  final helper = TvSeriesRepository();

  @override
  void onInit() {
    fetchSeries(); 
    super.onInit();
  }

  Future<void> fetchSeries() async {
    seriesList.value = await helper.fetchSeries();
    filteredList.value = seriesList;
  }

  Future<void> searchSeries(String query) async {
    if (query.isEmpty) {
      await fetchSeries();
    } else {
      seriesList.value = await helper.fetchSeries(searchText: query);
      filteredList.value = seriesList;
    }
  }
}

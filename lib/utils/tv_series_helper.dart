import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/movie_management/model/tv_series_model.dart';

class TvSeriesHelper {

  String baseUrl="https://imdb146.p.rapidapi.com/v1/";
  Future<List<TvSeriesModel>> fetchSeries({String? searchText}) async {
    final url = Uri.parse(
      '${baseUrl}find/?query=$searchText',
    );

    final response = await http.get(
      url,
      headers: {
        'X-RapidAPI-Key': '75a67df966msh11f382a7910a7c5p197ca0jsn23d02d2d85f4',
        'X-RapidAPI-Host': 'imdb146.p.rapidapi.com',
      },
  
    );

    final data = jsonDecode(response.body);
    final results = data['titleResults']['results'];

    return results
        .map<TvSeriesModel>((e) => TvSeriesModel.fromJson(e))
        .toList();
  }
}

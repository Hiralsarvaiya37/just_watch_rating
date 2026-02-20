import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_get/service/model/service_model.dart';

class ServiceRepository {
  Future<List<ServiceModel>> getData(int page, int limit) async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/albums?_page=$page&_limit=$limit"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return serviceModelFromJson(response.body);
    } else {
      throw Exception("Failed to load user");
    }
  }
}

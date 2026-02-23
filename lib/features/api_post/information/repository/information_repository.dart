import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_post/information/model/information_model.dart';

class InformationRepository {
  Future<InformationModel> userInfo(InformationModel model) async {
    final response = await http.post(
      Uri.parse("https://api.restful-api.dev/objects"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return InformationModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error: ${response.statusCode}");
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_post/user_id/model/user_details_id_model.dart';

class UserDetailsIdRepository {
  Future<List<UserDetailsIdModel>> getData() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData.map((e) => UserDetailsIdModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<UserDetailsIdModel> postData(UserDetailsIdModel user) async {
    final response = await http.post(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return UserDetailsIdModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to post data");
    }
  }
}

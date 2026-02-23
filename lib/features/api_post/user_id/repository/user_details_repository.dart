import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_post/user_id/model/user_details_model.dart';

class UserDetailsRepository {
  Future<UserDetailsModel> createPost(UserDetailsModel model) async {
    final response = await http.post(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 201) {
      return UserDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error: ${response.statusCode}");
    }
  }
}

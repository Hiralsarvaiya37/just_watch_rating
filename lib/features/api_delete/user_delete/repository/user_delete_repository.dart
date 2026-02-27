import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_delete/user_delete/model/user_delete_model.dart';

class UserDeleteRepository {
  Future<List<UserDeleteModel>> getData() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/comments"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => UserDeleteModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<bool> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse("https://jsonplaceholder.typicode.com/comments/$id"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception("Failed to delete post");
    }
  }
}

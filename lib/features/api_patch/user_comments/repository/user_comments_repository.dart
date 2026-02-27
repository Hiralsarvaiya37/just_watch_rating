import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_patch/user_comments/model/user_comments_model.dart';

class UserCommentsRepository {
  Future<List<UserCommentsModel>> getData() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/comments"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => UserCommentsModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<UserCommentsModel> updateData(UserCommentsModel model) async {
    final response = await http.patch(
      Uri.parse("https://jsonplaceholder.typicode.com/comments/${model.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserCommentsModel.fromJson(data);
    } else {
      throw Exception("Failed to update data");
    }
  }
}

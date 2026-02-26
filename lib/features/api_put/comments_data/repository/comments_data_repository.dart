import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_put/comments_data/model/comments_data_model.dart';

class CommentsDataRepository {
  Future<List<CommentsDataModel>> getData() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/comments"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);

      return jsonData.map((e) => CommentsDataModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to lost comments");
    }
  }

  Future<CommentsDataModel> updateData(CommentsDataModel model) async {
    final response = await http.put(
      Uri.parse("https://jsonplaceholder.typicode.com/comments/${model.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return CommentsDataModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update post");
    }
  }
}

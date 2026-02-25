import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_put/post_data/model/post_data_model.dart';

class PostDataRepository {
  Future<List<PostDataModel>> getData() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => PostDataModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }

  Future<PostDataModel> updateData(PostDataModel model) async {
    final response = await http.put(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/${model.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return PostDataModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update post");
    }
  }
}

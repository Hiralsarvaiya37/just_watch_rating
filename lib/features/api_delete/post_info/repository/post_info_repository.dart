import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_delete/post_info/model/post_info_model.dart';

class PostInfoRepository {
  Future<List<PostInfoModel>> getData() async {
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => PostInfoModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<bool> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/$id"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception("Failed to delete post");
    }
  }
}

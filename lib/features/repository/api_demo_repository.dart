import 'dart:convert';

import 'package:just_watch_rating/features/model/api_demo_model.dart';
import 'package:just_watch_rating/features/utils/api_helper.dart';

class ApiDemoRepository {
  Future<List<ApiDemoModel>> get() async {
    final response = await ApiHelper.get(
      url: "https://jsonplaceholder.typicode.com/comments",
      headers: {"Content-Type": "application/json"},
    );
    final List jsonData = jsonDecode(response.body);
    return jsonData.map((e) => ApiDemoModel.fromJson(e)).toList();
  }

  Future<ApiDemoModel> post(ApiDemoModel model) async {
    final response = await ApiHelper.post(
      url: "https://jsonplaceholder.typicode.com/comments",
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    return ApiDemoModel.fromJson(jsonData);
  }

  Future<ApiDemoModel> update(ApiDemoModel model) async {
    final response = await ApiHelper.put(
      url: "https://jsonplaceholder.typicode.com/comments/${model.id}",
      body: jsonEncode(model.toJson()),
    );

    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    return ApiDemoModel.fromJson(jsonData);
  }

  Future<bool> delete(int id) async {
    final response = await ApiHelper.delete(
      url: "https://jsonplaceholder.typicode.com/comments/$id",
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      throw Exception("Failed to delete comment: ${response.statusCode}");
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_patch/todos_details/model/todos_details_model.dart';

class TodosDetailsRepository {
  Future<List<TodosDetailsModel>> getData() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/todos"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => TodosDetailsModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<TodosDetailsModel> patchData(TodosDetailsModel model) async {
    final response = await http.patch(
      Uri.parse("https://jsonplaceholder.typicode.com/todos/${model.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return TodosDetailsModel.fromJson(data);
    } else {
      throw Exception("Failed to update data");
    }
  }
}

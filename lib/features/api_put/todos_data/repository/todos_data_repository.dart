import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_put/todos_data/model/todos_data_model.dart';

class TodosDataRepository {
  Future<List<TodosDataModel>> getData() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/todos"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => TodosDataModel.fromJson(e)).toList();
    } else {
      throw Exception("ailed to lost todos");
    }
  }

  Future<TodosDataModel> updateData(TodosDataModel model) async {
    final response = await http.put(
      Uri.parse("https://jsonplaceholder.typicode.com/todos/${model.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      return TodosDataModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update post");
    }
  }
}

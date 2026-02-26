import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_put/user_information/model/user_information_model.dart';

class UserInformationRepository {
  Future<List<UserInformationModel>> getData() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((e) => UserInformationModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<UserInformationModel> updateData(UserInformationModel model) async {
    final response = await http.put(
      Uri.parse("https://jsonplaceholder.typicode.com/users/${model.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return UserInformationModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update data");
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/users_model.dart';

class UsersRepository {

  Future<List<UsersModel>> getUsers() async {

    final response =
        await http.get(Uri.parse("https://dummyjson.com/users"));

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      List list = data['users'];

      return list
          .map((e) => UsersModel.fromJson(e))
          .toList();
    }

    return [];
  }

  Future<UsersModel?> updateUser({
    required int id,
    required String firstName,
    required int age,
  }) async {

    final response = await http.put(
      Uri.parse("https://dummyjson.com/users/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "firstName": firstName,
        "age": age,
      }),
    );

    if (response.statusCode == 200) {
      return UsersModel.fromJson(jsonDecode(response.body));
    }

    return null;
  }
}
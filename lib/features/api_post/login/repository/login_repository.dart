import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginRepository {
  Future<Map<String, dynamic>> loginUser(
    String username,
    String password,
  ) async {
    final url = Uri.parse('https://dummyjson.com/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username.trim(),
        'password': password.trim(),
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      try {
        final errorData = jsonDecode(response.body);
        throw Exception(
          errorData['message'] ?? 'Login failed (code: ${response.statusCode})',
        );
      } catch (e) {
        throw Exception(
          'Invalid response or network issue: ${response.statusCode}',
        );
      }
    }
  }
}

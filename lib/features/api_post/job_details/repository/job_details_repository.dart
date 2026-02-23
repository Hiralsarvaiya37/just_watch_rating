import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_post/job_details/model/job_details_model.dart';

class JobDetailsRepository {
  Future<JobDetailsModel> createUser(JobDetailsModel model) async {
    final response = await http.post(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );
    print("Status: ${response.statusCode}, Body: ${response.body}");
    print("Decoded JSON: $json");
    if (response.statusCode == 201) {
      return JobDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed: ${response.statusCode}");
    }
  }
}

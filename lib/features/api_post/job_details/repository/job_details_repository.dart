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
    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return JobDetailsModel(
        name: model.name,
        job: model.job,
        id: responseData['id'].toString(),
        createdAt: DateTime.now().toString(),
      );
    } else {
      throw Exception("Failed: ${response.statusCode}");
    }
  }
}

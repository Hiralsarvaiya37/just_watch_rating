import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_get/season/model/job_model.dart';

class JobRepository {
  Future<JobModel> getJobSalaryApi({
    required String searchText,
    required String countryCode,
  }) async {
    final url = Uri.parse(
      "https://jobs-api14.p.rapidapi.com/v2/salary/range?query=$searchText&countryCode=$countryCode",
    );

    final response = await http.get(
      url,
      headers: {
        "X-RapidAPI-Key": "75a67df966msh11f382a7910a7c5p197ca0jsn23d02d2d85f4",
        "X-RapidAPI-Host": "jobs-api14.p.rapidapi.com",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (jsonData['hasError'] == true) {
        throw Exception("API returned error: ${jsonData['errors']}");
      }

      return JobModel.fromJson(jsonData);
    } else {
      throw Exception("API call failed → ${response.statusCode}\n${response.body}");
    }
  }
}
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_get/job_title/model/job_title_model.dart';

class JobTitleRepository {
  Future<List<JobTitleModel>> getData() async {
    final response = await http.get(
      Uri.parse("https://jobs-api19.p.rapidapi.com/jobs?limit=10"),
      headers: {
        "x-rapidapi-host": "jobs-api19.p.rapidapi.com",
        "x-rapidapi-key": "75a67df966msh11f382a7910a7c5p197ca0jsn23d02d2d85f4",
      },
    );
    final List jsonData = jsonDecode(response.body);
    return jsonData.map((e) => JobTitleModel.fromJson(e)).toList();
  }
}

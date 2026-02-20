import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_get/comments/model/comments_model.dart';

class CommentsReository {
  Future<List<CommentsModel>> getData(int page, int limit) async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/comments?_page=$page&_limit=$limit"),
       headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return commentsModelFromJson(response.body);
    } else {
      throw Exception("Failed to load users");
    }
  }
}

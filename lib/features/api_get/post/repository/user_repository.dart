import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_get/post/model/user_model.dart';

class UserRepository {

  Future<List<UserModel>> getData() async {

    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    if (response.statusCode == 200) {
      return userModelFromJson(response.body);
    } else {
      throw Exception("Failed to load users");
    }
  }
}

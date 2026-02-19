import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/user_details/model/user_details_model.dart';

class UserDetailsRepository {

  Future<List<UserDetailsModel>> getData() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return userDetailsModelFromJson(response.body);
    } else {
      throw Exception("Failed to load users");
    }
  }
}

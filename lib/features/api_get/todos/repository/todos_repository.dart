import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_get/todos/model/todos_model.dart';

class TodosRepository {
  Future<List<TodosModel>> getData(int page, int limit) async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/todos?_page=$page&_limit=$limit"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return todosModelFromJson(response.body);
    } else {
     throw Exception("Failed to load todos: ${response.statusCode}");
    }
  }
}

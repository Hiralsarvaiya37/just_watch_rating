import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_post/cart/model/cart_model.dart';

class CartRepository {
  Future<CartModel> addCart(CartModel model) async {
    final response = await http.post(
      Uri.parse("https://dummyjson.com/carts/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return CartModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to add cart");
    }
  }
}
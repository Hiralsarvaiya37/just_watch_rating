import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_post/product/model/product_model.dart';

class ProductRepository {
  Future<ProductModel> createProduct(ProductModel model) async {
    final response = await http.post(
      Uri.parse("https://fakestoreapi.com/products"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 201) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed: ${response.statusCode}");
    }
  }
}

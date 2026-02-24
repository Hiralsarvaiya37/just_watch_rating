import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_post/product/model/product_model.dart';
import 'package:just_watch_rating/features/api_post/product/repository/product_repository.dart';

class ProductController extends GetxController {
  final isLoading = false.obs;
  final productData = Rxn<ProductModel>();
  final ProductRepository repository = ProductRepository();

  Future<void> createProduct({
    required String title,
    required String price,
    required String description,
    required String category,
  }) async {
    try {
      isLoading(true);

      final model = ProductModel(
        title: title,
        price: double.tryParse(price) ?? 0.0,
        description: description,
        image: "https://i.pravatar.cc",
        category: category,
      );
      final response = await repository.createProduct(model);
      productData.value = response;
      Get.snackbar(
        "Success",
        "Product Created Successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}

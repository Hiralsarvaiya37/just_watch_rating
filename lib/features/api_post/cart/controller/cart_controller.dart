import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_post/cart/model/cart_model.dart';
import 'package:just_watch_rating/features/api_post/cart/repository/cart_repository.dart';

class CartController extends GetxController {
  final isLoading = false.obs;
  final cartData = Rxn<CartModel>();
  final CartRepository repository = CartRepository();

  Future<void> createCart() async {
    try {
      isLoading(true);

      final cart = CartModel(
        userId: 5,
        products: [
          CartProduct(id: 1, quantity: 2),
          CartProduct(id: 2, quantity: 1),
        ],
      );

      final response = await repository.addCart(cart);

      cartData.value = response;

      Get.snackbar(
        "Success",
        "Cart Created Successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}

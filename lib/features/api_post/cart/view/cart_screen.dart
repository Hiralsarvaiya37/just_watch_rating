import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_post/cart/controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final CartController controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Cart",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return CircularProgressIndicator();
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: controller.createCart,
                child: Text("Create Cart"),
              ),

              SizedBox(height: 20),

              if (controller.cartData.value != null)
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Cart ID: ${controller.cartData.value!.id}"),
                        Text("User ID: ${controller.cartData.value!.userId}"),
                        Text("Total: ${controller.cartData.value!.total}"),
                        Text(
                          "Total Quantity: ${controller.cartData.value!.totalQuantity}",
                        ),
                        SizedBox(height: 20),
                        ...controller.cartData.value!.products!.map(
                          (p) => Text(
                            "${p.title} - Qty: ${p.quantity} - Total: ${p.total}",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

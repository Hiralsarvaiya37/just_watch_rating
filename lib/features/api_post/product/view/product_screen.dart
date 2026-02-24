import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:just_watch_rating/features/api_post/product/controller/product_controller.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final ProductController controller = Get.put(ProductController());
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Create product",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: "Category"),
              ),
              SizedBox(height: 20),

              Obx(() {
                return controller.isLoading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          controller.createProduct(
                            title: titleController.text,
                            price: priceController.text,
                            description: descriptionController.text,
                            category: categoryController.text,
                          );
                        },
                        child: Text("Create Product"),
                      );
              }),

              SizedBox(height: 30),
              Obx(() {
                final product = controller.productData.value;
                if (product == null) {
                  return Text("No Product Created");
                }
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ID: ${product.id}"),
                        Text("Title: ${product.title}"),
                        Text("Price: ${controller.productData.value?.price}"),
                        Text("Description: ${product.description}"),
                        Text("Image: ${controller.productData.value?.image}"),
                        Text("Category: ${product.category}"),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

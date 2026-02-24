class CartModel {
  int? id;
  int? userId;
  double? total;
  double? discountedTotal;
  int? totalQuantity;
  int? totalProducts;
  List<CartProduct>? products;

  CartModel({
    this.id,
    this.userId,
    this.total,
    this.discountedTotal,
    this.totalQuantity,
    this.totalProducts,
    this.products,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    total = (json['total'] as num?)?.toDouble();
    discountedTotal = (json['discountedTotal'] as num?)?.toDouble();
    totalQuantity = json['totalQuantity'];
    totalProducts = json['totalProducts'];

    if (json['products'] != null) {
      products = (json['products'] as List)
          .map((e) => CartProduct.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "products": products?.map((e) => e.toJson()).toList(),
    };
  }
}

class CartProduct {
  int? id;
  int? quantity;
  String? title;
  double? price;
  double? total;
  double? discountPercentage;
  double? discountedTotal;

  CartProduct({
    this.id,
    this.quantity,
    this.title,
    this.price,
    this.total,
    this.discountPercentage,
    this.discountedTotal,
  });

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    title = json['title'];
    price = (json['price'] as num?)?.toDouble();
    total = (json['total'] as num?)?.toDouble();
    discountPercentage =
        (json['discountPercentage'] as num?)?.toDouble();
    discountedTotal =
        (json['discountedTotal'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "quantity": quantity,
    };
  }
}
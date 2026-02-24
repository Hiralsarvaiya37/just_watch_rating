class ProductModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? image;
  String? category;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.image,
    this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'],
      image: json['image'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "price": price,
      "description": description,
      "image": image,
      "catrgory": category,
    };
  }
}

import 'dart:convert';

class ServiceModel {
  int userId;
  int id;
  String title;

  ServiceModel({required this.userId, required this.id, required this.title});

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {"userId": userId, "id": id, "title": title};
}

List<ServiceModel> serviceModelFromJson(String str) => List<ServiceModel>.from(
  json.decode(str).map((x) => ServiceModel.fromJson(x)),
);

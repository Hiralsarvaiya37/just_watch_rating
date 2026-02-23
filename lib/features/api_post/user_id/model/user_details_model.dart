class UserDetailsModel {
  int userId;
  int id;
  String title;
  String body;

  UserDetailsModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}


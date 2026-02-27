class UserDetailsIdModel {
  int userId;
  int id;
  String title;
  String body;

  UserDetailsIdModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory UserDetailsIdModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsIdModel(
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


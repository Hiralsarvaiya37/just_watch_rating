class CommentsDataModel {
  int postId;
  int id;
  String name;
  String email;
  String body;

  CommentsDataModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentsDataModel.fromJson(Map<String, dynamic> json) =>
      CommentsDataModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "id": id,
    "name": name,
    "email": email,
    "body": body,
  };
}

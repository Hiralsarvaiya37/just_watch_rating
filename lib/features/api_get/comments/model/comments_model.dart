import 'dart:convert';

class CommentsModel {
  int postId;
  int id;
  String name;
  String email;
  String body;

  CommentsModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
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

List<CommentsModel> commentsModelFromJson(String str) =>
    List<CommentsModel>.from(
      json.decode(str).map((x) => CommentsModel.fromJson(x)),
    );

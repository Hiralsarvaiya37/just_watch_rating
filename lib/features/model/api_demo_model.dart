class ApiDemoModel {
    int postId;
    int id;
    String name;
    String email;
    String body;

    ApiDemoModel({
        required this.postId,
        required this.id,
        required this.name,
        required this.email,
        required this.body,
    });

    factory ApiDemoModel.fromJson(Map<String, dynamic> json) => ApiDemoModel(
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

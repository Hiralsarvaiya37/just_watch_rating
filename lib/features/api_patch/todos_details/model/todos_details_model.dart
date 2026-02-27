class TodosDetailsModel {
    int userId;
    int id;
    String title;
    bool completed;

    TodosDetailsModel({
        required this.userId,
        required this.id,
        required this.title,
        required this.completed,
    });

    factory TodosDetailsModel.fromJson(Map<String, dynamic> json) => TodosDetailsModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
    };
}

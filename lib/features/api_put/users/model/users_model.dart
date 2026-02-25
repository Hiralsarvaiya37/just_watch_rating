class UsersModel {
  int? id;
  String? firstName;
  int? age;

  UsersModel({this.id, this.firstName, this.age});

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json['id'],
      firstName: json['firstName'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "firstName": firstName, "age": age};
  }
}

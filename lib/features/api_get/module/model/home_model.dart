class HomeModel {
  String? name;
  int? age;
  String? profession;

  HomeModel({this.name, this.age, this.profession});

  HomeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    profession = json['profession'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['age'] = age;
    data['profession'] = profession;
    return data;
  }
}

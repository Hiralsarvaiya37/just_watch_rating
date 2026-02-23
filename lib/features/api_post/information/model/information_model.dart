class InformationModel {
  String? id;
  String? name;
  Data? data;

  InformationModel({this.id, this.name, this.data});

  factory InformationModel.fromJson(Map<String, dynamic> json) {
    return InformationModel(
      id: json["id"],
      name: json["name"],
      data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "data": data?.toJson(),
    };
  }
}

class Data {
  String? color;
  String? capacity;

  Data({this.color, this.capacity});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      color: json["color"],
      capacity: json["capacity"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "color": color,
      "capacity": capacity,
    };
  }
}
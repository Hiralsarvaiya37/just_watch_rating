class JobDetailsModel {
  String? name;
  String? job;
  String? id;
  String? createdAt;

  JobDetailsModel({this.name, this.job, this.id, this.createdAt});

  factory JobDetailsModel.fromJson(Map<String, dynamic> json) {
    return JobDetailsModel(
      name: json["name"],
      job: json["job"],
      id: json["id"],
      createdAt: json["createdAt"],
    );
  }
  Map<String, dynamic> toJson() {
    return {"name": name, "job": job};
  }
}

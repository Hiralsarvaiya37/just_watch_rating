class JobTitleModel {
  int id;
  String title;
  String company;
  String aboutCompany;
  String jobDescription;
  String jobTitle;
  String jobType;
  String location;
  String experience;
  String roleAndResponsibility;
  String educationAndSkills;
  String applyLink;
  DateTime postedDate;

  JobTitleModel({
    required this.id,
    required this.title,
    required this.company,
    required this.aboutCompany,
    required this.jobDescription,
    required this.jobTitle,
    required this.jobType,
    required this.location,
    required this.experience,
    required this.roleAndResponsibility,
    required this.educationAndSkills,
    required this.applyLink,
    required this.postedDate,
  });

  factory JobTitleModel.fromJson(Map<String, dynamic> json) {
    return JobTitleModel(
      id: json["id"],
      title: json["title"],
      company: json["company"],
      aboutCompany: json["about_company"],
      jobDescription: json["job_description"],
      jobTitle: json["job_title"],
      jobType: json["job_type"],
      location: json["location"],
      experience: json["experience"],
      roleAndResponsibility: json["role_and_responsibility"],
      educationAndSkills: json["education_and_skills"],
      applyLink: json["apply_link"],
      postedDate: DateTime.parse(json["posted_date"]),
    );
  }
}
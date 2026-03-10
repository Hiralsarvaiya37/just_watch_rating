import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:just_watch_rating/features/api_get/job_title/controller/job_title_controller.dart';

class JobTitleScreen extends StatelessWidget {
  JobTitleScreen({super.key});
  final JobTitleController controller = Get.put(JobTitleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Job details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.userList.length,
                  itemBuilder: (context, index) {
                    final user = controller.userList[index];
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        subtitle: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ID: ${user.id}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("Title: ${user.title }"),
                              Text("Company: ${user.company}"),
                              Text("aboutCompany: ${user.aboutCompany}"),
                              SizedBox(height: 5),
                              Text("jobDescription: ${user.jobDescription}"),
                              SizedBox(height: 5),
                              Text("jobTitle: ${user.jobTitle}"),
                              Text("jobType: ${user.jobType}"),
                              Text("location: ${user.location}"),
                              Text("experience: ${user.experience}"),
                              SizedBox(height: 5),
                              Text(
                                "roleAndResponsibility:${user.roleAndResponsibility} ",
                              ),
                              SizedBox(height: 5),
                              Text(
                                "educationAndSkills: ${user.educationAndSkills}",
                              ),
                              Text("applyLink: ${user.applyLink}"),
                              Text("postedDate: ${user.postedDate}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/movie_management/controller/tv_series_controller.dart';

class TvSeriesScreen extends StatelessWidget {
  TvSeriesScreen({super.key});
  final controller = Get.put(TvSeriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Obx(
          () => controller.isSearching.value
              ? TextField(
                  cursorColor: Colors.greenAccent.shade700,
                  cursorWidth: 2,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search series...",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  
                  ),
                  onChanged: controller.searchSeries,
                )
              : Text(
                  "Tv Series",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              controller.isSearching.value = !controller.isSearching.value;
              controller.searchSeries("");
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(() {
          if (controller.filteredList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            itemCount: controller.filteredList.length,
            itemBuilder: (context, index) {
              final item = controller.filteredList[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      item.image,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    item.title,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    item.description,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(
                      (item.rating / 2).round(),
                      (context) =>
                          Icon(Icons.star, color: Colors.yellow, size: 22),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 22),
          );
        }),
      ),
    );
  }
}

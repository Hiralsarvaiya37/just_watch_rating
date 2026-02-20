import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_watch_rating/features/api_get/music/controller/music_controller.dart';

class MusicScreen extends StatelessWidget {
  MusicScreen({super.key});
  final MusicController controller = Get.put(MusicController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Music",
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
        if (controller.musicData.value == null) {
          return Center(child: Text("No Data Found"));
        }
        var data = controller.musicData.value!;
        return Padding(
          padding: EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: data.states.length,
            itemBuilder: (context, index) {
              var state = data.states[index];
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ICAO24: ${state[0] ?? ""}"),
                      Text("Callsign: ${state[1] ?? ""}"),
                      Text("Country: ${state[2] ?? ""}"),
                      Text("Longitude: ${state[5] ?? ""}"),
                      Text("Latitude: ${state[6] ?? ""}"),
                      Text("Altitude: ${state[7] ?? ""}"),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

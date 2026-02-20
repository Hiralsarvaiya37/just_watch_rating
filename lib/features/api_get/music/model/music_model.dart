import 'dart:convert';

class MusicModel {
    int time;
    List<List<dynamic>> states;

    MusicModel({
        required this.time,
        required this.states,
    });

    factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
        time: json["time"],
        states: List<List<dynamic>>.from(json["states"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "time": time,
        "states": List<dynamic>.from(states.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}
MusicModel musicModelFromJson(String str) => MusicModel.fromJson(json.decode(str));

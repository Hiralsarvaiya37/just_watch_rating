import 'package:http/http.dart' as http;
import 'package:just_watch_rating/features/api_get/music/model/music_model.dart';

class MusicRepository {
  Future<MusicModel> getData() async {
    final response = await http.get(
      Uri.parse(
        "https://opensky-network.org/api/states/all?lamin=45.8389&lomin=5.9962&lamax=47.8229&lomax=10.5226",
      ),
      headers: {"Content-Type": "application/json"},
    );
     if(response.statusCode == 200){
      return musicModelFromJson(response.body);
     }else{
      throw Exception("Failed to load data");
     }
  }
}

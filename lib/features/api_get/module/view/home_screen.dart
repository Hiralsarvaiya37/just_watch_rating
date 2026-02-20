import 'package:flutter/material.dart';
import 'package:just_watch_rating/features/api_get/module/model/home_model.dart';
import 'package:just_watch_rating/features/api_get/module/view/internet_connectivity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HomeModel> nameList = [
    HomeModel(name: "abc", age: 20, profession: "hwbdwh"),
    HomeModel(name: "def", age: 21, profession: "nbhwd"),
    HomeModel(name: "hij", age: 22, profession: "ndwdnw"),
    HomeModel(name: "nsj", age: 22, profession: "hsbs"),
    HomeModel(name: "aws", age: 22, profession: "hsbs"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text(
          "Model Classes",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: nameList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(nameList[index].name.toString()),
            subtitle: Text(nameList[index].age.toString()),
            trailing: IconButton(
              onPressed: () {
                nameList.removeAt(index);
                setState(() {});
              },
              icon: Icon(Icons.delete, size: 25),
            ),
          );
        },
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InternetConnectivity()),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Text(
              "Go to next screen..",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}

// class Names {
//   String name;
//   int age;
//   DateTime dob;

//   Names({required this.name, required this.age, required this.dob});
// }

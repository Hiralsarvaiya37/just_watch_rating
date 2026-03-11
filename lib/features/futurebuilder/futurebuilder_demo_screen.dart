import 'package:flutter/material.dart';

class FuturebuilderDemoScreen extends StatelessWidget {
  const FuturebuilderDemoScreen({super.key});

  Future<String> getData() async {
    await Future.delayed(Duration(seconds: 2));
    return "Hello FutureBuilder";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "FutureBuilder Example",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return Text(
                snapshot.data.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              );
            }
          },
        ),
      ),
    );
  }
}

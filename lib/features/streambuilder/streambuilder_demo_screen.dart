import 'package:flutter/material.dart';

class StreambuilderDemoScreen extends StatelessWidget {
  const StreambuilderDemoScreen({super.key});
  Stream<int> numberStream() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(Duration(seconds: 2));
      yield i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "StreamBuilder Example",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: StreamBuilder(
          stream: numberStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return Text(
                "Number: ${snapshot.data}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              );
            }
            return Text("No data");
          },
        ),
      ),
    );
  }
}

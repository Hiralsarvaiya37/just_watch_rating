import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetConnectivity extends StatelessWidget {
  const InternetConnectivity({super.key});

  Future<bool> checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    // print(result);
    return result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, size: 25, color: Colors.white),
        ),
        title: Text(
          "Internet Connectivity",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder<bool>(
            future: checkInternet(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.data == true) {
                return Text(
                  "Internet Connected",
                  style: TextStyle(fontSize: 18, color: Colors.green),
                );
              } else {
                return Text(
                  "No Internet",
                  style: TextStyle(fontSize: 18, color: Colors.red),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'log/login.dart';
import 'mainbar.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOYS Fishing App',
      home: FutureBuilder(
        future: _getLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data == true ? MainBar() : LoginPage();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<bool> _getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
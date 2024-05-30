import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dart_boysfishing/log/login.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({super.key});
 
  @override
  State<SessionPage> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
        backgroundColor: Colors.white,
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Logout'),
          onPressed: () async { 
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', false);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'login-main.dart';


class TokenCheck extends StatefulWidget {
  const TokenCheck({super.key});
 
  @override
  State<TokenCheck> createState() => _TokenCheckScreenState();
}

class _TokenCheckScreenState extends State<TokenCheck> {
  bool isToken = false;
 
  @override
  void initState() {
    super.initState();
    _autoLoginCheck();
  }
 
  void _autoLoginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
 
    if (token != null) {
      setState(() {
        isToken = true;
      });
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isToken ? MainPage() : LoginPage(),
    );
  }
}
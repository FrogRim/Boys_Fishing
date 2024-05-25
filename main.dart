import 'package:flutter/material.dart';
import 'basebar.dart';

void main() {
  //dbConnector('selectAll');
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOYS Fishing App',
      home: MainBar(),
    );
  }
}
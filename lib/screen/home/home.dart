import 'package:flutter/material.dart';

import 'package:dart_boysfishing/constants.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
 
  @override
  State<HomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c_ContainerDarkColor,
      appBar: AppBar(
        title: Text('홈'),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          
          Text('A')
        ],
      ),
    );
  }
}
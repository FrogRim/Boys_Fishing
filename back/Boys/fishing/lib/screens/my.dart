import 'package:flutter/material.dart';


class MyPage extends StatefulWidget {
  const MyPage({super.key});
 
  @override
  State<MyPage> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:fishing/widgets/Bottom_navbar.dart'; // 여기서 'your_file_name.dart'는 GoogleBottomBar 클래스를 포함한 파일의 이름으로 변경하세요.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App with Google Bottom Bar',
      home: BottomBar(), 
    );
  }
}

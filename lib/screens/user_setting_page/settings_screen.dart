import 'package:flutter/material.dart';
import 'package:flutter_application_1/senior/s_home_screen.dart'; // 시니어 모드의 홈 화면을 포함한 파일을 임포트합니다

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정', style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.black),
            title: Text('알림 설정', style: TextStyle(color: Colors.black)),
            onTap: () {
              // 알림 설정 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.language, color: Colors.black),
            title: Text('언어 설정', style: TextStyle(color: Colors.black)),
            onTap: () {
              // 언어 설정 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.color_lens, color: Colors.black),
            title: Text('테마 설정', style: TextStyle(color: Colors.black)),
            onTap: () {
              // 테마 설정 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.accessibility_new, color: Colors.black),
            title: Text('시니어 모드', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SeniorHomeScreen()), // 시니어 모드의 홈 화면으로 변경
                (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.black),
            title: Text('개인정보 보호', style: TextStyle(color: Colors.black)),
            onTap: () {
              // 개인정보 보호 설정 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.black),
            title: Text('앱 정보', style: TextStyle(color: Colors.black)),
            onTap: () {
              // 앱 정보 페이지로 이동
            },
          ),
        ],
      ),
    );
  }
}

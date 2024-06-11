import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('알림 설정'),
            onTap: () {
              // 알림 설정 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('언어 설정'),
            onTap: () {
              // 언어 설정 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('테마 설정'),
            onTap: () {
              // 테마 설정 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('개인정보 보호'),
            onTap: () {
              // 개인정보 보호 설정 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('앱 정보'),
            onTap: () {
              // 앱 정보 페이지로 이동
            },
          ),
        ],
      ),
    );
  }
}

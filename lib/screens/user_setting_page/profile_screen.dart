import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/user_setting_page/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/profile_image.png'), // 프로필 이미지
            ),
            SizedBox(height: 10),
            Text(
              '사용자 이름',
              style: TextStyle(
                fontFamily: 'Gamtanload',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'user@example.com',
              style: TextStyle(
                fontFamily: 'Gamtanload',
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text(
                '프로필 수정',
                style: TextStyle(
                  fontFamily: 'Gamtanload',
                ),
              ),
              onTap: () {
                // 프로필 수정 페이지로 이동
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text(
                '비밀번호 변경',
                style: TextStyle(
                  fontFamily: 'Gamtanload',
                ),
              ),
              onTap: () {
                // 비밀번호 변경 페이지로 이동
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text(
                '주문 내역',
                style: TextStyle(
                  fontFamily: 'Gamtanload',
                ),
              ),
              onTap: () {
                // 주문 내역 페이지로 이동
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text(
                '즐겨찾기',
                style: TextStyle(
                  fontFamily: 'Gamtanload',
                ),
              ),
              onTap: () {
                // 즐겨찾기 페이지로 이동
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                '로그아웃',
                style: TextStyle(
                  fontFamily: 'Gamtanload',
                ),
              ),
              onTap: () {
                // 로그아웃 기능
              },
            ),
          ],
        ),
      ),
    );
  }
}

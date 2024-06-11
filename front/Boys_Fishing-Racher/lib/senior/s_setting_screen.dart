import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/season_pass_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeniorProfileScreen extends StatefulWidget {
  @override
  _SeniorProfileScreenState createState() => _SeniorProfileScreenState();
}

class _SeniorProfileScreenState extends State<SeniorProfileScreen> {
  bool isSeniorMode = true;

  @override
  void initState() {
    super.initState();
    _loadSeniorMode();
  }

  _loadSeniorMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSeniorMode = prefs.getBool('isSeniorMode') ?? true;
    });
  }

  _toggleSeniorMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSeniorMode = value;
      prefs.setBool('isSeniorMode', value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '프로필 및 설정',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Row(
            children: [
              Text(
                '시니어 모드',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Switch(
                value: isSeniorMode,
                onChanged: _toggleSeniorMode,
                activeColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/profile_image.png'), // 프로필 이미지
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              '사용자 이름',
              style: TextStyle(
                fontFamily: 'Gamtanload',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 5),
          Center(
            child: Text(
              'user@example.com',
              style: TextStyle(
                fontFamily: 'Gamtanload',
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          ListTile(
            leading: Icon(Icons.person, size: 30, color: Colors.black),
            title: Text(
              '프로필 수정',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              // 프로필 수정 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.card_membership, size: 30, color: Colors.black),
            title: Text(
              '시즌패스',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SeasonPassScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.security, size: 30, color: Colors.black),
            title: Text(
              '비밀번호 변경',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              // 비밀번호 변경 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.history, size: 30, color: Colors.black),
            title: Text(
              '주문 내역',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              // 주문 내역 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite, size: 30, color: Colors.black),
            title: Text(
              '즐겨찾기',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              // 즐겨찾기 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications, size: 30, color: Colors.black),
            title: Text(
              '알림 설정',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              // 알림 설정 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.language, size: 30, color: Colors.black),
            title: Text(
              '언어 설정',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              // 언어 설정 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.color_lens, size: 30, color: Colors.black),
            title: Text(
              '테마 설정',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              // 테마 설정 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.lock, size: 30, color: Colors.black),
            title: Text(
              '개인정보 보호',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              // 개인정보 보호 설정 페이지로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.info, size: 30, color: Colors.black),
            title: Text(
              '앱 정보',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              // 앱 정보 페이지로 이동
            },
          ),
          ListTile(
              leading: Icon(Icons.logout, size: 30, color: Colors.black),
              title: Text(
                '로그아웃',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              onTap: () {
                // 로그아웃 기능
              }),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/log_in/login_screen.dart';
import 'package:flutter_application_1/screens/user_setting_page/settings_screen.dart';
import 'package:flutter_application_1/screens/season_pass_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screens/log_in/login_screen.dart';
import 'package:http/http.dart' as http;
import 'show_shoppingcart.dart';
import 'dart:convert'; 

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSeniorMode = false;
  String userName = '';
  String userEmail = '';
  @override
  void initState() {
    super.initState();
    _loadSeniorMode();
  }

  _loadSeniorMode() async {
    final prefs = await SharedPreferences.getInstance();
    bool loadedValue = prefs.getBool('isSeniorMode') ?? false;
    print("Loaded isSeniorMode: $loadedValue");  // 로드된 값 로깅
    setState(() {
      userEmail = prefs.getString('userEmail') ?? 'Unknown User';
      userName = prefs.getString('username') ?? 'user@example.com';
      isSeniorMode = loadedValue;
    });
  }

  _toggleSeniorMode(bool value) async {

    print("Toggle Senior Mode: $value");
    final prefs = SharedPreferences.getInstance();
    prefs.then((preferences) {
      preferences.setBool('isSeniorMode', value);
      setState(() {
        isSeniorMode = value;
      });
    }).catchError((e) {
      print("Failed to toggle senior mode: $e");
    });
  }

Future<List<dynamic>> fetchShoppingCart() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? authToken = prefs.getString('accessToken');
  final url = Uri.parse('http://10.0.2.2:8000/shops/shopping-cart/');

  final response = await http.get(url, headers: {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json; charset=UTF-8',
  });

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load shopping cart');
  }
}

Future<void> logoutUser() async {
  var url = Uri.parse('http://10.0.2.2:8000/accounts/logout/'); // 로그아웃 API URL
  var response = await http.post(url);

  if (response.statusCode == 204) {
    print("Logged out successfully");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken'); // 액세스 토큰 삭제
    await prefs.remove('userName'); // 사용자 이름 삭제
    await prefs.remove('userEmail'); // 사용자 이메일 삭제

    // 로그인 화면으로 이동
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen()));
  } else {
    print("Failed to log out");
  }
}
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'),
        actions: [
          Text("시니어 모드"),
          Switch(
            value: isSeniorMode,
            onChanged: _toggleSeniorMode,
            activeColor: Colors.blue,
          ),
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
               userName,
              style: TextStyle(
                fontFamily: 'Gamtanload',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              userEmail,
              style: TextStyle(
                fontFamily: 'Gamtanload',
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            ListTile(
              leading: Icon(Icons.card_membership),
              title: Text(
                '시즌패스',
                style: TextStyle(
                  fontFamily: 'Gamtanload',
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SeasonPassScreen()),
                );
              },
            ),
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
              onTap: ()async  {
                // 주문 내역 페이지로 이동
                try {
                      List<dynamic> cartItems = await fetchShoppingCart();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowShoppingCartScreen(cartItems: cartItems),
                        ),
                      );
                    } catch (e) {
                      print("Error fetching cart items: $e");
                    }
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
                logoutUser(); // 로그아웃 함수 호출
  
                
            
          },
        ),
      ],
        ),
      ),
    );
  }
}
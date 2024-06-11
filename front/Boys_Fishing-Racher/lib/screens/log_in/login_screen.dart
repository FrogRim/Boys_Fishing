import 'package:flutter/material.dart';
//import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false; // 자동로그인 체크박스 상태

  Future<void> performLogin() async {
  var url = Uri.parse('http://10.0.2.2:8000/accounts/login/');  // Django 백엔드 API 엔드포인트
  
  var response = await http.post(url, body: {
    'email': _emailController.text,
    'password': _passwordController.text,
  });

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    // 로그인 성공 처리, 홈 스크린으로 리디렉션
    print('Login successful: ${data['tokens']}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', data['user_id']); // 사용자 ID 저장
    await prefs.setString('userEmail', data['email']);
    await prefs.setString('username', data['name']);
    // Access 토큰 저장
    await prefs.setString('accessToken', data['tokens']['access']);
    // 필요하다면 Refresh 토큰도 저장
    await prefs.setString('refreshToken', data['tokens']['refresh']); // 토큰 저장
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
  } else {
    // 로그인 실패 처리
    print('Login failed: ${response.body}');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Failed'),
        content: Text('Invalid credentials.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'assets/icons/logo.png', // 로고 이미지
                    height: 100,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "로그인 페이지",
                  style: TextStyle(
                    fontFamily: 'Gamtanload',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 80),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                      child: SvgPicture.asset("assets/icons/Mail.svg"),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                      child: SvgPicture.asset("assets/icons/Lock.svg"),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                    ),
                    Text("자동로그인"),
                    Spacer(),
                    Text(
                      "비밀번호를 잊었어요",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // 로그인 버튼의 배경 색상
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // 버튼 모서리의 둥글기
                      ),
                    ),
                    onPressed: () {
                      // Perform login logic
                     performLogin();

                    },
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        fontFamily: 'Gamtanload',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "계정이 없으신가요? ",
                      style: TextStyle(
                        fontFamily: 'Gamtanload',
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to signup screen
                        Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterScreen()));
                      },
                      child: Text(
                        "회원가입",
                        style: TextStyle(
                          fontFamily: 'Gamtanload',
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fishing/main.dart';
import 'login-main.dart';


// Stateless 위젯으로 토큰 검사를 수행하는 클래스
class TokenCheck extends StatelessWidget {
  const TokenCheck({super.key});

  // SharedPreferences에서 'token' 값을 비동기적으로 확인하는 함수
  Future<bool> _checkToken() async {
    final prefs = await SharedPreferences.getInstance(); // SharedPreferences 인스턴스를 가져옵니다
    final token = prefs.getString('token'); // 'token' 키로 저장된 값을 가져옵니다
    return token != null; // 토큰이 있다면 true, 없다면 false를 반환
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue, // 앱의 주 색상을 파란색으로 설정
        visualDensity: VisualDensity.adaptivePlatformDensity, // 레이아웃 밀도를 설정
      ),
      // FutureBuilder를 사용하여 비동기 작업 처리
      home: FutureBuilder<bool>(
        future: _checkToken(), // _checkToken 함수의 결과를 Future로 받습니다
        builder: (context, snapshot) {
          // 연결 상태가 대기 중일 때
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()), // 로딩 인디케이터를 중앙에 표시
            );
          }
          // 스냅샷에 에러가 포함된 경우
          if (snapshot.hasError) {
            // 에러 메시지를 화면에 표시
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'), // 에러 상황을 설명하는 텍스트
              ),
            );
          }
          // 토큰의 유무에 따라 적절한 화면으로 리다이렉션
          return snapshot.data == true ? MyApp() : LoginPage(redirectPage: 0,); // 토큰이 있으면 MyApp으로, 없으면 LoginPage로 이동
        },
      ),
    );
  }
}
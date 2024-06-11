import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fishing/screens/home.dart';
import 'package:fishing/screens/my.dart';
import 'package:fishing/screens/community/community_screen.dart';
import 'package:fishing/screens/shop.dart';
import 'package:fishing/screens/auth/login-main.dart'; // login-main.dart 파일 경로가 올바른지 확인하세요.

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  List<Widget> _pages = [

    //LoginPage(int, redirectPage: 0),
    HomePage(),
    MyPage(),
    CommunityScreen(),
    ShopPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main page')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: _handleIndexChanged,
        items: _navBarItems,
      ),
    );
  }

  void _handleIndexChanged(int index) async {
    // SharedPreferences를 통해 로컬에 저장된 토큰을 확인합니다.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // 토큰이 없고 선택된 페이지가 홈 페이지가 아니라면 로그인 페이지로 이동합니다.
    if (token == null) {
      // 로그인 페이지로 네비게이션하면서 로그인 성공 후 리다이렉션할 인덱스를 전달합니다.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(redirectPage: 0)
        ),
      ).then((value) {
        // 로그인 후에 돌아오면, 사용자가 선택한 페이지 인덱스를 적용합니다.
       if(value != null && value is int){

          setState(() {
            _selectedIndex = index;
          });
       }
      });
    } else {
      // 토큰이 있거나 홈 페이지를 선택한 경우, 해당 페이지로 상태를 업데이트합니다.
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}

final _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home), label: "Home"),
  BottomNavigationBarItem(
    icon: Icon(Icons.account_circle_rounded), label: "My page"),
  BottomNavigationBarItem(
    icon: Icon(Icons.commute_rounded), label: "Community"),
  BottomNavigationBarItem(
    icon: Icon(Icons.shop_2_rounded), label: "Shop"),
];

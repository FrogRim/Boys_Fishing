import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screens/log_in/login_screen.dart';
// 일반모드 스크린
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/community/community_screen.dart';
import 'package:flutter_application_1/screens/map/map_screen.dart';
import 'package:flutter_application_1/screens/shopping/shopping_screen.dart';
import 'package:flutter_application_1/screens/user_setting_page/profile_screen.dart';


//시니어모드 스크린
import 'package:flutter_application_1/senior/s_home_screen.dart';
import 'package:flutter_application_1/senior/s_setting_screen.dart';
import 'package:flutter_application_1/senior/s_community.dart';
import 'package:flutter_application_1/senior/s_shop/s_shopping.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 추가
  
  SystemChrome.setPreferredOrientations([
    // 추가
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    final prefs = await SharedPreferences.getInstance();
    final isSeniorMode = prefs.getBool('isSeniorMode') ?? false;
    runApp(MyApp(isSeniorMode: !isSeniorMode));
  }); // 추가
}

class MyApp extends StatelessWidget {
  final bool isSeniorMode;

  MyApp({required this.isSeniorMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isSeniorMode ? SeniorMainScreen() : MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2; // 기본 선택된 인덱스 (홈 화면)
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      CommunityScreen(),
      MapScreen(),
      HomeScreen(
        onFishingTapped: _onFishingTapped,
        onTravelTapped: _onTravelTapped,
      ),
      ShoppingScreen(),
      ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken'); // 'token'은 저장된 토큰의 키

    if (token == null) {
      Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen())); // 로그인 페이지로 리다이렉트
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _onFishingTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTravelTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // 추가적으로, ShoppingScreen 내에서 Travel 페이지를 선택
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShoppingScreen(initialIndex: 1)),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '맵',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '쇼핑',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class SeniorMainScreen extends StatefulWidget {
  @override
  _SeniorMainScreenState createState() => _SeniorMainScreenState();
}

class _SeniorMainScreenState extends State<SeniorMainScreen> {
  int _selectedIndex = 2; // 기본 선택된 인덱스 (홈 화면)
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      SeniorCommunityScreen(),
      SeniorMapScreen(),
      SeniorHomeScreen(),
      SeniorShoppingScreen(),
      SeniorProfileScreen(),
    ];
  }

  void _onItemTapped(int index)async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // 'token'은 저장된 토큰의 키

    if (token == null) {
      Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen())); // 로그인 페이지로 리다이렉트
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _onFishingTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTravelTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // 추가적으로, ShoppingScreen 내에서 Travel 페이지를 선택
      // Navigator.push(
      // context,
      // MaterialPageRoute(
      //     builder: (context) => SeniorShoppingScreen(initialIndex: 1)),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people, size: 30),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, size: 30),
            label: '맵',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 30),
            label: '쇼핑',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,
        selectedFontSize: 20,
        unselectedFontSize: 18,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class SeniorMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '시니어 맵 화면',
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class TravelPackagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: Image.asset('assets/test_image/travel_package_1.jpg',
                width: 50, height: 50, fit: BoxFit.cover),
            title: Text('여행 패키지 1'),
            subtitle: Text('특가 여행 패키지'),
            onTap: () {
              // 상세 페이지로 이동
            },
          ),
          ListTile(
            leading: Image.asset('assets/test_image/travel_package_2.jpg',
                width: 50, height: 50, fit: BoxFit.cover),
            title: Text('여행 패키지 2'),
            subtitle: Text('가성비 좋은 여행 패키지'),
            onTap: () {
              // 상세 페이지로 이동
            },
          ),
          // 다른 여행 패키지 추가
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FishingGearPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: Image.asset('assets/test_image/fishing_rod.jpg',
                width: 50, height: 50, fit: BoxFit.cover),
            title: Text('낚시대'),
            subtitle: Text('고품질 낚시대'),
            onTap: () {
              // 상세 페이지로 이동
            },
          ),
          ListTile(
            leading: Image.asset('assets/test_image/fishing_reel.jpg',
                width: 50, height: 50, fit: BoxFit.cover),
            title: Text('릴'),
            subtitle: Text('내구성 좋은 릴'),
            onTap: () {
              // 상세 페이지로 이동
            },
          ),
          // 다른 낚시 용품 추가
        ],
      ),
    );
  }
}

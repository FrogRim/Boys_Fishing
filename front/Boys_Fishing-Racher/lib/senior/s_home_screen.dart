import 'package:flutter/material.dart';
import 'package:flutter_application_1/senior/widget/s_home_category.dart';

class SeniorHomeScreen extends StatefulWidget {
  @override
  _SeniorHomeScreenState createState() => _SeniorHomeScreenState();
}

class _SeniorHomeScreenState extends State<SeniorHomeScreen> {
  final List<String> notifications = [
    '알림 1: 새로운 댓글이 달렸습니다.',
    '알림 2: 새로운 좋아요가 있습니다.',
    '알림 3: 새로운 메시지가 도착했습니다.',
    // 추가적인 알림들
  ];

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('알림 목록'),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(notifications[index]),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('닫기'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '시니어 피싱',
          style: TextStyle(
            fontFamily: 'Gamtanload',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, size: 30),
            onPressed: () => _showNotifications(context),
            color: Colors.black,
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                AdsSection(),
                SeniorCategorySection(),
                CommunityPreview(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Center(child: Image.asset('assets/test_image/advertisement.png')),
    );
  }
}

class CommunityPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.grey[300],
      child: Center(
        child: Text(
          '커뮤니티 미리보기 섹션',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}
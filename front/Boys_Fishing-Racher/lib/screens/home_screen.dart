import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/home_category_section.dart';
import 'package:flutter_application_1/widgets/home_ads_section.dart';
import 'package:flutter_application_1/widgets/home_community_preview.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onFishingTapped;
  final Function(int) onTravelTapped;

  HomeScreen({required this.onFishingTapped, required this.onTravelTapped});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          'Boys Fishing',
          style: TextStyle(
            fontFamily: 'Gamtanload',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => _showNotifications(context),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                AdsSection(),
                CategorySection(
                  onFishingTapped: widget.onFishingTapped,
                  onTravelTapped: widget.onTravelTapped,
                ),
                CommunityPreview(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SeasonPassScreen extends StatefulWidget {
  @override
  _SeasonPassScreenState createState() => _SeasonPassScreenState();
}

class _SeasonPassScreenState extends State<SeasonPassScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '시즌 진행 상황',
          style: TextStyle(
            fontFamily: 'Gamtanload',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '진행중인 미션'),
            Tab(text: '완료된 미션'),
            Tab(text: '보상 목록'),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Image.asset(
            'assets/icons/season_pass_icon.png', // 생성된 아이콘 파일 경로
            width: 100,
            height: 100,
          ),
          SizedBox(height: 20),
          Text(
            '70% 완료',
            style: TextStyle(
              fontFamily: 'Gamtanload',
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: 0.7, // 예제 진행 상황 (70%)
            minHeight: 20,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: 20),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOngoingMissions(),
                _buildCompletedMissions(),
                _buildRewardList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOngoingMissions() {
    List<Map<String, dynamic>> missions = [
      {'title': '20마리의 물고기 잡기', 'progress': 10, 'total': 20, 'xp': 50},
      {'title': '특별 이벤트 참여', 'progress': 1, 'total': 1, 'xp': 100},
      {'title': '희귀 물고기 5마리 잡기', 'progress': 2, 'total': 5, 'xp': 75},
      {'title': '친구와 함께 낚시', 'progress': 0, 'total': 1, 'xp': 30},
    ];

    return ListView(
      children: missions.map((mission) {
        double progressValue = mission['progress'] / mission['total'];
        return ListTile(
          leading: Icon(Icons.assignment, color: Colors.orange),
          title: Text(
            mission['title'],
            style: TextStyle(fontFamily: 'Gamtanload', fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: progressValue,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
              SizedBox(height: 5),
              Text(
                  '${mission['progress']} / ${mission['total']} 완료, 경험치: ${mission['xp']} XP')
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCompletedMissions() {
    List<Map<String, dynamic>> missions = [
      {'title': '20마리의 물고기 잡기', 'xp': 50},
      {'title': '특별 이벤트 참여', 'xp': 100},
      {'title': '희귀 물고기 5마리 잡기', 'xp': 75},
      {'title': '친구와 함께 낚시', 'xp': 30},
    ];

    return ListView(
      children: missions.map((mission) {
        return ListTile(
          leading: Icon(Icons.check_circle, color: Colors.blue),
          title: Text(
            mission['title'],
            style: TextStyle(fontFamily: 'Gamtanload', fontSize: 16),
          ),
          subtitle: Text('경험치: ${mission['xp']} XP'),
        );
      }).toList(),
    );
  }

  Widget _buildRewardList() {
    List<String> rewards = [
      '새로운 낚싯대',
      '고급 미끼 세트',
      '특별 낚시 의상',
      '희귀 물고기 스킨',
      '추가 경험치 부스트'
    ];

    return ListView(
      children: rewards.map((reward) {
        return ListTile(
          leading: Icon(Icons.card_giftcard, color: Colors.green),
          title: Text(
            reward,
            style: TextStyle(fontFamily: 'Gamtanload', fontSize: 16),
          ),
        );
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/community/create_post_screen.dart';

class SeniorCommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              '커뮤니티',
              style: TextStyle(
                fontFamily: 'Gamtanload',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(),
            backgroundColor: Colors.white,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildPostItem(context);
              },
              childCount: 1, // 게시물 수
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          );
        },
        child: Icon(Icons.add, size: 30),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildPostItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 사용자 정보
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
                'assets/test_image/community_user_image.png'), // 프로필 이미지
            radius: 30,
          ),
          title: Text(
            '사용자 이름',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('2시간 전', style: TextStyle(fontSize: 20)),
          trailing: Icon(Icons.more_vert, size: 30),
        ),
        // 게시글 이미지
        Image.asset(
          'assets/test_image/community_page_image.png', // 게시글 이미지
          fit: BoxFit.cover,
        ),
        // 좋아요, 댓글, 공유 아이콘
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite_border, size: 30),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.comment, size: 30),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.share, size: 30),
                    onPressed: () {},
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.bookmark_border, size: 30),
                onPressed: () {},
              ),
            ],
          ),
        ),
        // 좋아요 수 및 설명
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '좋아요 120개',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  children: [
                    TextSpan(
                      text: '사용자 이름',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' 게시글 내용 예시...'),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '댓글 모두 보기',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              SizedBox(height: 8.0),
              // 댓글
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  children: [
                    TextSpan(
                      text: '다른 사용자',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' 댓글 예시...'),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}

import 'package:flutter/material.dart';


class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});
 
  @override
  State<CommunityPage> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityPage> {
  final List<Post> posts = [
    Post(title: '인기 게시물 1', likes: 5, comments: 2),
    Post(title: '인기 게시물 2', likes: 3, comments: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('커뮤니티'),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {}, // 검색 기능 추가 예정
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(posts[index].title),
            subtitle: Text('좋아요 ${posts[index].likes}, 댓글 ${posts[index].comments}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () {
                    setState(() {
                      posts[index].likes++;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Post {
  String title;
  int likes;
  int comments;

  Post({required this.title, required this.likes, required this.comments});
}
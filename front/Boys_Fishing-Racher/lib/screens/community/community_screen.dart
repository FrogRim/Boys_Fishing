import 'package:flutter/material.dart';
//import 'package:flutter_application_1/screens/community/create_post_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'create_post_screen.dart';
class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _commentController = TextEditingController();

 // API에서 게시글 목록을 가져오는 함수
  Future<List<dynamic>> fetchPosts() async {
    var url = Uri.parse('http://10.0.2.2:8000/boards/posts/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

    // 게시글에 댓글을 달기 위한 함수
  Future<void> postComment(int postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    String? accessToken = prefs.getString('accessToken');

    var url = Uri.parse('http://10.0.2.2:8000/boards/comments/');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'post': postId,
        'author': userId,
        'content': _commentController.text,
      }),
    );

    if (response.statusCode == 201) {
      print('Comment posted successfully');
      _commentController.clear();
    } else {
      print('Failed to post comment: ${response.body}');
    }
  }

  // 게시글에 좋아요 토글
  Future<void> toggleLike(int postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    

    var url = Uri.parse('http://10.0.2.2:8000/boards/likes/$postId/toggle/');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
      'post': postId,
    }),
    );

    if (response.statusCode == 200) {
      print('Like toggled successfully');
    } else {
      print('Failed to toggle like');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Community', style: TextStyle(fontWeight: FontWeight.bold)),
            floating: true,
            pinned: true,
          ),
          FutureBuilder<List<dynamic>>(
            future: fetchPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverFillRemaining(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return SliverFillRemaining(child: Text("Error: ${snapshot.error}"));
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var post = snapshot.data![index];
                    return ListTile(
                      title: Text(post['title']),
                      subtitle: Text(post['content']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${post['comments_count']} comments'),
                          IconButton(
                            icon: Icon(Icons.comment),
                            onPressed: () => _showCommentDialog(context, post['id']),
                          ),
                          Text('${post['likes_count']} likes'),
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () => toggleLike(post['id']),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: snapshot.data?.length ?? 0,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostScreen()),
        );
  },
  child: Icon(Icons.add), // 아이콘 사용
  backgroundColor: Colors.blue, // 버튼의 배경색을 파란색으로 설정
  tooltip: 'Create Post', // 툴팁 추가
      ),
    );
  }

  // 댓글 작성 다이얼로그 표시
  void _showCommentDialog(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Post a Comment'),
          content: TextField(
            controller: _commentController,
            decoration: InputDecoration(hintText: "댓글작성"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Post'),
              onPressed: () {
                postComment(postId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}

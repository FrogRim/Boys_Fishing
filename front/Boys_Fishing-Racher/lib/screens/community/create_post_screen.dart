import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class CreatePostScreen extends StatelessWidget {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  

  Future<void> submitPost(BuildContext context) async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');  // getInt 메서드 사용
 // 저장된 사용자 ID 불러오기
    
    var url = Uri.parse('http://10.0.2.2:8000/boards/posts/');  // Django 백엔드 API URL
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('accessToken')}', // 토큰 사용
      },
      body: jsonEncode({
        'author': userId,
        'title': _titleController.text,
        'content': _contentController.text,
      }),
    );

    if (response.statusCode == 201) {
      print('Post created successfully.');
      var data = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('postId',data['id']);
      Navigator.pop(context);
    } else {
      print('Failed to create post: ${response.body}');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registration Failed'),
          content: Text('Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('새 게시물'),
        actions: [
          TextButton(
            onPressed: ()=> submitPost(context),
            child: Text('완료', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(  // 제목을 위한 TextField 추가
            controller: _titleController,
            decoration: InputDecoration(
              labelText: '제목',  // 제목 입력란 레이블
              border: OutlineInputBorder(),  // 입력란에 테두리 추가
            ),
          ),
          SizedBox(height: 10),  // 제목과 내용 입력란 사이에 간격 추가
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: '무슨 생각을 하고 계신가요?',
                  border: InputBorder.none,
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
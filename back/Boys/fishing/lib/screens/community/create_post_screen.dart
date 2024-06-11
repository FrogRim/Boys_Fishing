import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreatePostScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('새 글 작성'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '제목'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: '내용'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String title = _titleController.text;
                String content = _contentController.text;

                if (title.isNotEmpty && content.isNotEmpty) {
                  var response = await createPost(title, content);
                  if (response.statusCode == 201) {
                    Navigator.pop(context);
                  } else {
                    // 서버 오류 처리
                    showErrorDialog(context);
                  }
                } else {
                  // 입력 값 오류 처리
                  showErrorDialog(context, message: '제목과 내용을 모두 입력하세요.');
                }
              },
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }

  Future<http.Response> createPost(String title, String content) async {
    return await http.post(
      Uri.parse('http://127.0.0.1:8000/boards/posts/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'content': content,
      }),
    );
  }

  void showErrorDialog(BuildContext context, {String message = '오류가 발생했습니다. 다시 시도해주세요.'}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('오류'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('확인'),
          ),
        ],
      ),
    );
  }
}

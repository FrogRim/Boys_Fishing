import 'package:flutter/material.dart';
import 'package:flutter_application_1/db_helper.dart';

class CreatePostScreen extends StatelessWidget {
  final TextEditingController _contentController = TextEditingController();

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
            onPressed: () async {
              String content = _contentController.text;

              if (content.isNotEmpty) {
                await DBHelper().insertPost({
                  'content': content,
                });

                Navigator.pop(context);
              } else {
                // 오류 처리: 빈 필드 알림
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('오류'),
                    content: Text('내용을 입력하세요.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('확인'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text(
              '완료',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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

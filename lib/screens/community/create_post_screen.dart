import 'package:flutter/material.dart';
import 'package:flutter_application_1/db_helper.dart';

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
                  await DBHelper().insertPost({
                    'title': title,
                    'content': content,
                  });

                  Navigator.pop(context);
                } else {
                  // 오류 처리: 빈 필드 알림
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('오류'),
                      content: Text('제목과 내용을 모두 입력하세요.'),
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
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}

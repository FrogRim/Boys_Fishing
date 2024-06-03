import 'package:flutter/material.dart';

class CommunityPreview extends StatelessWidget {
  final List<Map<String, String>> popularPosts = [
    {'title': '인기 글 1', 'content': '이것은 인기 글 1의 미리보기입니다.'},
    {'title': '인기 글 2', 'content': '이것은 인기 글 2의 미리보기입니다.'},
    {'title': '인기 글 3', 'content': '이것은 인기 글 3의 미리보기입니다.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '인기글',
            style: TextStyle(
              fontFamily: 'Gamtanload',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: popularPosts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                popularPosts[index]['title']!,
                style: TextStyle(
                  fontFamily: 'Gamtanload',
                  fontSize: 16,
                ),
              ),
              subtitle: Text(popularPosts[index]['content']!),
              onTap: () {
                // 인기 글 상세 페이지로 이동
              },
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class AdsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
        ),
        Container(
          width: MediaQuery.of(context).size.width, // 화면의 너비에 맞춤
          height: 200,
          child: Image.asset(
            'assets/icons/boys_fishing_banner.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}

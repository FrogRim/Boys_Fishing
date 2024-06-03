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
          height: 200,
          child: Image.asset(
            'assets/test_image/advertisement.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}

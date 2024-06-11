import 'package:flutter/material.dart';

class AdsBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PageView(
        children: [
          Image.asset('assets/test_image/fishing_rod.jpg', fit: BoxFit.cover),
          Image.asset('assets/test_image/fishing_reel.jpg', fit: BoxFit.cover),
          Image.asset('assets/test_image/fishing_line.jpg', fit: BoxFit.cover),
        ],
      ),
    );
  }
}

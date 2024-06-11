import 'package:flutter/material.dart';

class SeniorAdsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0), // 더 큰 패딩
          child: Container(
            height: 350, // 더 큰 높이
            child: PageView(
              children: [
                Stack(
                  children: [
                    Image.asset('assets/test_image/advertisement1.jpg',
                        fit: BoxFit.cover),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(
                        '광고 1',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Image.asset('assets/test_image/advertisement2.jpg',
                        fit: BoxFit.cover),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(
                        '광고 2',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
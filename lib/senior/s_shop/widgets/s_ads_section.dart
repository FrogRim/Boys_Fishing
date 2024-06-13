import 'package:flutter/material.dart';

class SeniorAdsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 300,
            child: PageView(
              children: [
                Image.asset('assets/test_image/advertisement1.jpg',
                    fit: BoxFit.cover),
                Image.asset('assets/test_image/advertisement2.jpg',
                    fit: BoxFit.cover),
              ],
            ),
          ),
        )
      ],
    );
  }
}

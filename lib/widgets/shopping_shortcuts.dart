import 'package:flutter/material.dart';

class ShoppingShortcuts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildShortcutIcon('assets/test_image/icon1.jpg', 'Category 1'),
          _buildShortcutIcon('assets/test_image/icon2.jpg', 'Category 2'),
          _buildShortcutIcon('assets/test_image/icon3.jpg', 'Category 3'),
          _buildShortcutIcon('assets/test_image/icon4.jpg', 'Category 4'),
          _buildShortcutIcon('assets/test_image/icon5.jpg', 'Category 5'),
        ],
      ),
    );
  }

  Widget _buildShortcutIcon(String imagePath, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 38,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}

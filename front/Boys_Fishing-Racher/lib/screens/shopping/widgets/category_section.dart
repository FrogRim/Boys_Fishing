import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.only(bottom: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryIcon('assets/test_image/fishing_rod.jpg', '낚시대'),
          _buildCategoryIcon('assets/test_image/fishing_reel.jpg', '릴'),
          _buildCategoryIcon('assets/test_image/fishing_line.jpg', '낚시줄'),
          _buildCategoryIcon('assets/test_image/fishing_lure.jpg', '루어'),
          _buildCategoryIcon('assets/test_image/fishing_hook.jpg', '바늘'),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(String imagePath, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 38,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 8),
          Container(
            width: 70,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

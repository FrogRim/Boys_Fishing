import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryIcon('assets/test_image/fishing_tool.jpg', '낚시용품'),
          _buildCategoryIcon('assets/test_image/treaval.jpg', '여행상품'),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(String imagePath, String label) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 38,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 8),
          Text(label),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}

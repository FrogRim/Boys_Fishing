import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  final Function(int) onFishingTapped;
  final Function(int) onTravelTapped;

  CategorySection(
      {required this.onFishingTapped, required this.onTravelTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryIcon(context, 'assets/test_image/fishing_tool.jpg',
              '낚시용품', onFishingTapped),
          _buildCategoryIcon(
              context, 'assets/test_image/treaval.jpg', '여행상품', onTravelTapped),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(BuildContext context, String imagePath,
      String label, Function(int) onTap) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => onTap(3), // 전달된 콜백을 사용하여 인덱스를 변경
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
            ),
          ],
        ),
      ),
    );
  }
}
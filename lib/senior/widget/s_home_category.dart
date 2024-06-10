import 'package:flutter/material.dart';
import 'package:flutter_application_1/senior/s_shop/s_shopping.dart';
import 'package:flutter_application_1/screens/shopping/travel_packages_page.dart';

class SeniorCategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryIcon(context, 'assets/test_image/fishing_tool.jpg',
              '낚시용품', SeniorShoppingScreen(initialIndex: 0)),
          _buildCategoryIcon(context, 'assets/test_image/treaval.jpg', '여행상품',
              SeniorShoppingScreen(initialIndex: 1)),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(
      BuildContext context, String imagePath, String label, Widget targetPage) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );
        },
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

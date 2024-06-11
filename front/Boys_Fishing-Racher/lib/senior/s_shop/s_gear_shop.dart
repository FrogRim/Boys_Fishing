import 'package:flutter/material.dart';
import 'package:flutter_application_1/senior/s_shop/widgets/s_ads_section.dart';
import 'package:flutter_application_1/senior/s_shop/widgets/s_category_section.dart';
import 'package:flutter_application_1/senior/s_shop/widgets/s_recommended_products.dart';


class SeniorFishingGearPage extends StatelessWidget {
  
  final bool isSearching;
  final Function(bool) toggleSearch;

  SeniorFishingGearPage(
      {
      required this.isSearching,
      required this.toggleSearch});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => toggleSearch(false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SeniorAdsSection(),
                SeniorCategorySection(),
                SeniorRecommendedProducts(),
              ],
            ),
          ),
        ),
        if (isSearching)
          GestureDetector(
            onTap: () => toggleSearch(false),
            child: Container(
              color: Colors.black54,
            ),
          ),
      ],
    );
  }
}

class SeniorAdsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.grey[300],
      child: Center(
        child: Text(
          '광고 섹션',
          style: TextStyle(fontSize: 28, color: Colors.black),
        ),
      ),
    );
  }
}

class SeniorCategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.grey[300],
      child: Center(
        child: Text(
          '카테고리 섹션',
          style: TextStyle(fontSize: 28, color: Colors.black),
        ),
      ),
    );
  }
}

class SeniorRecommendedProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.grey[300],
      child: Center(
        child: Text(
          '추천 제품 섹션',
          style: TextStyle(fontSize: 28, color: Colors.black),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_application_1/senior/s_shop/widgets/s_ads_section.dart';
import 'package:flutter_application_1/senior/s_shop/widgets/s_category_section.dart';
import 'package:flutter_application_1/senior/s_shop/widgets/s_recommended_products.dart';
import 'package:flutter_application_1/db_helper.dart';

class SeniorFishingGearPage extends StatelessWidget {
  final DBHelper dbHelper;
  final bool isSearching;
  final Function(bool) toggleSearch;

  SeniorFishingGearPage(
      {required this.dbHelper,
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

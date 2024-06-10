import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/shopping/widgets/category_section.dart';
import 'package:flutter_application_1/screens/shopping/widgets/recommended_products.dart';
import 'package:flutter_application_1/screens/shopping/widgets/ads_section.dart';
import 'package:flutter_application_1/db_helper.dart';

class FishingGearPage extends StatelessWidget {
  final DBHelper dbHelper;
  final bool isSearching;
  final Function(bool) toggleSearch;

  FishingGearPage(
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
                AdsSection(),
                CategorySection(),
                RecommendedProducts(),
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

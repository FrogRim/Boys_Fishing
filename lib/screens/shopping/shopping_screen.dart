import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/shopping/widgets/category_section.dart';
import 'package:flutter_application_1/screens/shopping/widgets/recommended_products.dart';
import 'package:flutter_application_1/screens/shopping/widgets/ads_section.dart';
import 'package:flutter_application_1/db_helper.dart';
import 'package:flutter_application_1/widgets/search_app_bar.dart'; // SearchAppBar import

class ShoppingScreen extends StatefulWidget {
  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  final DBHelper dbHelper = DBHelper();
  bool _isSearching = false;

  void _toggleSearch(bool isSearching) {
    setState(() {
      _isSearching = isSearching;
    });
  }

  void _insertSampleProduct() async {
    await dbHelper.insertProduct({
      'name': '낚시대',
      'price': 50000,
      'description': '고급 낚시대',
    });
  }

  void _getProducts() async {
    List<Map<String, dynamic>> products = await dbHelper.getProducts();
    // 제품 목록 처리
    print(products);
  }

  @override
  Widget build(BuildContext context) {
    _insertSampleProduct(); // 샘플 데이터 삽입
    _getProducts(); // 제품 목록 조회

    return Scaffold(
      appBar: SearchAppBar(
        title: "보이스 피싱 샵",
        onSearchToggle: _toggleSearch, // 콜백 함수 전달
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => _toggleSearch(false),
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
          if (_isSearching)
            GestureDetector(
              onTap: () => _toggleSearch(false),
              child: Container(
                color: Colors.black54, // 블라인드 처리
              ),
            ),
        ],
      ),
    );
  }
}

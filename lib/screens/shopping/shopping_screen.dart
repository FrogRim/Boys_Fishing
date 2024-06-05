import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/shopping/widgets/category_section.dart';
import 'package:flutter_application_1/screens/shopping/widgets/recommended_products.dart';
import 'package:flutter_application_1/screens/shopping/widgets/ads_section.dart';
import 'package:flutter_application_1/db_helper.dart';
import 'package:flutter_application_1/screens/shopping/fishing_gear_page.dart';
import 'package:flutter_application_1/screens/shopping/travel_packages_page.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  final DBHelper dbHelper = DBHelper();
  bool _isSearching = false;
  int _selectedIndex = 0;

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

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _insertSampleProduct(); // 샘플 데이터 삽입
    _getProducts(); // 제품 목록 조회

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              )
            : Row(
                children: [
                  GestureDetector(
                    onTap: () => _onTabTapped(0),
                    child: Text(
                      '  샵   ',
                      style: TextStyle(
                        color:
                            _selectedIndex == 0 ? Colors.black : Colors.black54,
                        fontWeight: _selectedIndex == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Text('\|', style: TextStyle(color: Colors.black54)),
                  GestureDetector(
                    onTap: () => _onTabTapped(1),
                    child: Text(
                      '   여행  ',
                      style: TextStyle(
                        color:
                            _selectedIndex == 1 ? Colors.black : Colors.black54,
                        fontWeight: _selectedIndex == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
        actions: [
          if (!_isSearching)
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => _toggleSearch(true),
              color: Colors.black,
            ),
          if (_isSearching)
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => _toggleSearch(false),
              color: Colors.black,
            ),
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => _toggleSearch(false),
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                FishingGearPage(
                    dbHelper: dbHelper,
                    isSearching: _isSearching,
                    toggleSearch: _toggleSearch),
                TravelPackagesPage(),
              ],
            ),
          ),
          if (_isSearching)
            GestureDetector(
              onTap: () => _toggleSearch(false),
              child: Container(
                color: Colors.black54,
              ),
            ),
        ],
      ),
    );
  }
}

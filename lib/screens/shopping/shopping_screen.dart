import 'package:flutter/material.dart';
import 'package:flutter_application_1/db_helper.dart';
import 'package:flutter_application_1/screens/shopping/fishing_gear_page.dart';
import 'package:flutter_application_1/screens/shopping/travel_packages_page.dart';

class ShoppingScreen extends StatefulWidget {
  final int initialIndex;

  ShoppingScreen({this.initialIndex = 0});

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  final DBHelper dbHelper = DBHelper();
  bool _isSearching = false;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

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

  void _closeSearch() {
    setState(() {
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _insertSampleProduct(); // 샘플 데이터 삽입
    _getProducts(); // 제품 목록 조회

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue[900]!,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue[900]!,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue[900]!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        // 검색 기능 수행
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.black),
                      onPressed: _closeSearch,
                    ),
                  ],
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
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _closeSearch,
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
              onTap: _closeSearch,
              child: Container(
                color: Colors.black54,
              ),
            ),
        ],
      ),
    );
  }
}

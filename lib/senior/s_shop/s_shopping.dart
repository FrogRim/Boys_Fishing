import 'package:flutter/material.dart';
import 'package:flutter_application_1/db_helper.dart';
import 'package:flutter_application_1/senior/s_shop/s_gear_shop.dart';
import 'package:flutter_application_1/screens/shopping/travel_packages_page.dart';

class SeniorShoppingScreen extends StatefulWidget {
  final int initialIndex;

  SeniorShoppingScreen({this.initialIndex = 0});

  @override
  _SeniorShoppingScreenState createState() => _SeniorShoppingScreenState();
}

class _SeniorShoppingScreenState extends State<SeniorShoppingScreen> {
  final DBHelper dbHelper = DBHelper();
  bool _isSearching = false;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _insertSampleProduct();
    _getProducts();
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
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
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
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Text('\|',
                      style: TextStyle(color: Colors.black54, fontSize: 24)),
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
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
        actions: [
          if (!_isSearching)
            IconButton(
              icon: Icon(Icons.search, size: 30),
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
                SeniorFishingGearPage(
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

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/screens/shopping/fishing_gear_page.dart';
import 'package:flutter_application_1/screens/shopping/travel_packages_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingScreen extends StatefulWidget {
  final int initialIndex;

  ShoppingScreen({this.initialIndex = 0});

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  
  bool _isSearching = false;
  late int _selectedIndex;
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _fetchProducts();
  }

  void _fetchProducts() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/shops/products/'));
    
    if (response.statusCode == 200) {
      setState(() {
        products = jsonDecode(response.body);
        
      });
    } else {
      // Error handling
      print('Failed to load products');
    }
  }


  void _toggleSearch(bool isSearching) {
    setState(() {
      _isSearching = isSearching;
    });
  }

Future<void> _addToCart(int productId) async {

  final prefs = await SharedPreferences.getInstance();
  final String? authToken = prefs.getString('accessToken');
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/shops/shopping-cart/add_to_cart/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(<String, int>{'product_id': productId}),
    );



    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Product added to cart successfully'),
      ));
    } else {
      // Error handling
      print('Failed to add product to cart');
    }

    
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
       body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index]['name']),
            subtitle: Text('Price: ${products[index]['price']}'),
            onTap: () => _addToCart(products[index]['id']),
          );
        },
      ),
    );
  }
}
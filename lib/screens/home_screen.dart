import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/home_category_section.dart';
import 'package:flutter_application_1/widgets/home_ads_section.dart';
import 'package:flutter_application_1/widgets/home_community_preview.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
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
                height: 40,
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              )
            : Text(
                'Boys Fishing',
                style: TextStyle(
                  fontFamily: 'Gamtanload',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          if (!_isSearching)
            IconButton(
              icon: Icon(Icons.search),
              onPressed: _toggleSearch,
            ),
          if (!_isSearching)
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // 알림 페이지로 이동
              },
            ),
        ],
      ),
      body: GestureDetector(
        onTap: _closeSearch,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  AdsSection(),
                  CategorySection(),
                  CommunityPreview(),
                ],
              ),
            ),
            if (_isSearching)
              SliverFillRemaining(
                child: Container(
                  color: Colors.black54,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

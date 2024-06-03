import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function(bool) onSearchToggle;

  SearchAppBar({required this.title, required this.onSearchToggle});

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      widget.onSearchToggle(_isSearching); // 부모 위젯에 검색 상태 알림
      if (!_isSearching) {
        _searchController.clear();
      }
    });
  }

  void _closeSearch() {
    setState(() {
      _isSearching = false;
      widget.onSearchToggle(_isSearching); // 부모 위젯에 검색 상태 알림
      _searchController.clear();
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _isSearching
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.blue.shade900), // 검색창 테두리 색상 설정
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                cursorColor: Colors.blue.shade900, // 커서 색상 설정
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            )
          : Text(widget.title,
              style: TextStyle(
                fontFamily: 'Gamtanload',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
      actions: [
        if (_isSearching)
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Perform search action
              print('Searching for: ${_searchController.text}');
            },
          ),
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          onPressed: _toggleSearch,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'screen/community/community.dart';
import 'screen/home/home.dart';
import 'screen/map/map.dart';
import 'screen/my/my.dart';
import 'screen/shop/shop.dart';


class MainBar extends StatefulWidget {
  const MainBar({super.key});
 
  @override
  State<MainBar> createState() => _MainBarState();
}
 
class _MainBarState extends State<MainBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _index = 2;
 
  @override
  void initState() {
    super.initState();
 
    _tabController = TabController(length: _navItems.length, vsync: this);
    _tabController.addListener(tabListener);
  }
 
  @override
  void dispose() {
    _tabController.removeListener(tabListener);
    super.dispose();
  }
 
  void tabListener() {
    setState(() {
      _index = _tabController.index;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        onTap: (int index) {
          _tabController.animateTo(index);
        },
        currentIndex: _index,
        items: _navItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(_index == item.index ? item.activeIcon : item.inactiveIcon,),
            label: item.label,
          );
        }).toList(),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          CommunityPage(),
          MapPage(),
          HomePage(),
          ShopPage(),
          MyPage(),
        ],
      ),
  );
  }
}

class NavItem {
  final int index;
  final IconData activeIcon;
 
  final IconData inactiveIcon;
  final String label;
 
  const NavItem({
    required this.index,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
  });
}

const _navItems = [
  NavItem(
    index: 0,
    activeIcon: Icons.chat,
    inactiveIcon: Icons.chat_outlined,
    label: '커뮤니티',
  ),
  NavItem(
    index: 1,
    activeIcon: Icons.map,
    inactiveIcon: Icons.map_outlined,
    label: '지도',
  ),
  NavItem(
    index: 2,
    activeIcon: Icons.home,
    inactiveIcon: Icons.home_outlined,
    label: '홈',
  ),
  NavItem(
    index: 3,
    activeIcon: Icons.shop_2,
    inactiveIcon: Icons.shop_2_outlined,
    label: '쇼핑몰',
  ),
  NavItem(
    index: 4,
    activeIcon: Icons.person,
    inactiveIcon: Icons.person_outline,
    label: '마이페이지',
  ),
];
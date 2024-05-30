import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'screen/community/community.dart';
import 'screen/home/home.dart';
import 'screen/map/map.dart';
import 'screen/my/my.dart';
import 'screen/shop/shop.dart';
import 'constants.dart';


class MainBar extends StatefulWidget {
  const MainBar({super.key});
 
  @override
  State<MainBar> createState() => _MainBarState();
}
 
class _MainBarState extends State<MainBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _index = 4;

  final List<Widget> _navIdex = [
    CommunityPage(),
    MapPage(),
    HomePage(),
    ShopPage(),
    MyPage(),
  ];
 
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color.fromARGB(176, 158, 158, 158),
              blurRadius: 5,
            ),
          ],
        ),
        height: 70,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 2,
          showSelectedLabels: true,
          selectedIconTheme: IconThemeData(
            color: c_LogoBrightColor,
          ),
          showUnselectedLabels: false,
          selectedItemColor: c_LogoBrightColor,
          unselectedItemColor: const Color.fromARGB(255, 189, 189, 189),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          onTap: (int index) {
            _tabController.animateTo(index);
          },
          currentIndex: _index,
          items: _navItems.map((item) {
            return BottomNavigationBarItem(
              label: item.label,
              icon: Icon(_index == item.index ? item.activeIcon : item.inactiveIcon, size: item.size),
            );
          }).toList(),
      )),
      body: _navIdex.elementAt(_index)
    );
  }
}

class NavItem {
  final int index;
  final double size;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;
 
  const NavItem({
    required this.index,
    required this.size,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
  });
}

const _navItems = [
  NavItem(
    index: 0,
    size: 25,
    activeIcon: Icons.chat,
    inactiveIcon: Icons.chat_outlined,
    label: 'Sns',
  ),
  NavItem(
    index: 1,
    size: 25,
    activeIcon: Icons.map,
    inactiveIcon: Icons.map_outlined,
    label: 'Spot',
  ),
  NavItem(
    index: 2,
    size: 29,
    activeIcon: Icons.home,
    inactiveIcon: Icons.home_outlined,
    label: 'Home',
  ),
  NavItem(
    index: 3,
    size: 23,
    activeIcon: Icons.shop,
    inactiveIcon: Icons.shop_outlined,
    label: 'Shop',
  ),
  NavItem(
    index: 4,
    size: 25,
    activeIcon: Icons.person,
    inactiveIcon: Icons.person_outlined,
    label: 'My',
  ),
];
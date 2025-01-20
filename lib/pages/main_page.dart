import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:find_restaurant/pages/home_page.dart';
import 'package:find_restaurant/pages/search_page.dart';
import 'package:find_restaurant/pages/setting_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _page = 0;
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    SettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).primaryColor,
        items: [
          CurvedNavigationBarItem(
              child: Icon(
                Icons.home_outlined,
              ),
              label: 'Home'),
          CurvedNavigationBarItem(
              child: Icon(
                Icons.search_outlined,
              ),
              label: 'Search'),
          CurvedNavigationBarItem(
              child: Icon(
                Icons.settings_outlined,
              ),
              label: 'Setting'),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: SafeArea(
          child: IndexedStack(
        index: _page,
        children: _pages,
      )),
    );
  }
}

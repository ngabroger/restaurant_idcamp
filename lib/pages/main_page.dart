import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:find_restaurant/controllers/page_provider.dart';
import 'package:find_restaurant/pages/home_page.dart';
import 'package:find_restaurant/pages/search_page.dart';
import 'package:find_restaurant/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favorite_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    FavoritePage(),
    SettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<PageProvider>(
        builder: (context, value, child) {
          return CurvedNavigationBar(
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
                    Icons.favorite_border_outlined,
                  ),
                  label: 'Favorite'),
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.settings_outlined,
                  ),
                  label: 'Setting'),
            ],
            onTap: (index) {
              value.setPage(index);
            },
          );
        },
      ),
      body: SafeArea(child: Consumer<PageProvider>(
        builder: (context, value, child) {
          return IndexedStack(
            index: value.page,
            children: _pages,
          );
        },
      )),
    );
  }
}

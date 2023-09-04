import 'package:flutter/material.dart';
import 'package:read_manga/presentation/pages/manga_list_page.dart';
import 'package:read_manga/presentation/pages/manga_recommended_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.refresh_outlined),
      label: 'Latest',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.recommend_outlined),
      label: 'Recommend',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.remove_red_eye),
      label: 'Watchlist',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info_outline),
      label: 'About',
    ),
  ];

  final List<Widget> _listWidget = [
    MangaListPage(),
    MangaRecommended(),
    MangaListPage(),
    MangaListPage(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white38,
        selectedItemColor: Colors.white,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}

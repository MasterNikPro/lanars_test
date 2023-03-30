import 'package:flutter/material.dart';
import 'package:lanars_test/features/home/screens/home_screen.dart';
import 'package:lanars_test/features/home/screens/search_screen.dart';

import '../../../utils/bottom_navigation_bar_elements.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    int? _selectedIndex;
    return BottomNavigationBar(
      items: bottom_navigation_items,
      currentIndex: _selectedIndex == null ? 0 : _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (int index) {
        _selectedIndex = index;
        switch (index) {
          case 0:
            if (_selectedIndex == index) {
              Navigator.of(context).pushAndRemoveUntil(
                  _createRoute(HomePage()), (route) => false);
            }
            break;
          case 1:
            if (_selectedIndex == index) {
              Navigator.of(context).pushAndRemoveUntil(
                  _createRoute(SearchScreen()), (route) => false);
            }
        }
      },
    );
  }
}

Route _createRoute(Widget route) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => route,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

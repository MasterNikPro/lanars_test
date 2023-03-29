import 'package:flutter/material.dart';

import '../../../utils/bottom_navigation_bar_elements.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return BottomNavigationBar(
      items: bottom_navigation_items,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (int index) {
        switch(index){
          case 0:
            if(_selectedIndex==index){
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }
            break;
          case 1:
            Navigator.pushNamedAndRemoveUntil(context, '/search_screen', (route) => false);
        }
      },
    );
  }
}

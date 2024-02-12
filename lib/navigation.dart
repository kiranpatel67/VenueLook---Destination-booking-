import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_route.dart';

class NavigationMenu extends StatelessWidget {
  final RxInt selectedIndex = 0.obs; // Add RxInt to manage state

  NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex.value,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: _getColor(0)),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book, color: _getColor(1)),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: _getColor(2)),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        selectedIndex.value = index;
        _navigateToPage(index);
      },
    );
  }

  Color _getColor(int index) {
    return selectedIndex.value == index ? Colors.blue : Colors.black;
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed(AppRoute.homePage);
        break;
      case 1:
        Get.offAllNamed(AppRoute.bookingsPage);
        break;
      case 2:
        Get.offAllNamed(AppRoute.profilePage);
        break;
    }
  }
}

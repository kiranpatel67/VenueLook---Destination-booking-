import 'package:FoGraph/presentation/bookings/bookings_page.dart';
import 'package:FoGraph/presentation/home/home_screen.dart';
import 'package:FoGraph/presentation/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../routes/app_route.dart';


class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0, // You can set the initial tab index here
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
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
      },
    );
  }
}


class CommonPageStructure extends StatelessWidget {
  final Widget pageContent;

  const CommonPageStructure({Key? key, required this.pageContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageContent,
      bottomNavigationBar: NavigationBar(),
    );
  }
}

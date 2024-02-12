import 'package:FoGraph/navigation.dart';
import 'package:FoGraph/presentation/bookings/controller/bookings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:FoGraph/routes/app_route.dart';

class BookingsPage extends StatelessWidget {
  final BookingsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      appBar: AppBar(
        title: Text('Bookings'),
      ),
      body: Column(
        children: [
          _buildTabBar(),
          _buildTabView(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTabItem('Upcoming', 0),
          _buildTabItem('Completed', 1),
          _buildTabItem('Cancelled', 2),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        controller.changesubTabIndex(index);
      },
      child: Obx(
            () => Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: controller.selectedsubtabIndex.value == index
                    ? Colors.blue
                    : Colors.black,
              ),
            ),
            Container(
              height: 2.0,
              width: 60.0,  // Adjust the width to your desired length
              color: controller.selectedsubtabIndex.value == index
                  ? Colors.blue
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTabView() {
    return Expanded(
      child: Obx(
            () => IndexedStack(
          index: controller.selectedsubtabIndex.value,
          children: [
            _buildTabContent('Upcoming Content'),
            _buildTabContent('Completed Content'),
            _buildTabContent('Cancelled Content'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String content) {
    return Center(
      child: Text(
        content,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: controller.selectedIndex.value,
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
        controller.changeTabIndex(index);
        _navigateToPage(index);
      },
    );
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


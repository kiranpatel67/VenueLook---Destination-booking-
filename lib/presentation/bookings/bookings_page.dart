import 'dart:ffi';

import 'package:FoGraph/navigation.dart';
import 'package:FoGraph/presentation/bookings/controller/bookings_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:shimmer/shimmer.dart';

import '../../Data_model/HomeScreen_data_model.dart';

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
          Expanded( // Use Expanded here to give the tab view a fixed height
            child: _buildTabView(),
          ),
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
            () =>
            Column(
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
                  width: 60.0, // Adjust the width to your desired length
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
    return Obx(
          () =>
          IndexedStack(
            index: controller.selectedsubtabIndex.value,
            children: [
              _buildTabContent(),
              // Remove the string argument, since it doesn't affect the rendering
              _buildTabContent(),
              _buildTabContent(),
            ],
          ),
    );
  }

  Widget _buildTabContent() {
    return Center(
      child: Bookinglist(),
    );
  }

  void _navigateToHomePage() {
    Get.offAllNamed(AppRoute.homePage);
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

  Widget Bookinglist() {
    return Obx(
          () {
        if (controller.randomDestinations.value.isEmpty) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.separated(
              itemCount: 10, // Show a placeholder for 10 items
              separatorBuilder: (context, index) =>
                  Padding(padding: EdgeInsets.only(bottom: 20)),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(1),
                        margin: EdgeInsets.all(3),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[300],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[300],
                                  height: 16,
                                  width: double.infinity,
                                ),
                              ),
                              SizedBox(height: 4),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[300],
                                  height: 14,
                                  width: double.infinity,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }

        return ListView.separated(
          itemCount: controller.randomDestinations.value.length,
          separatorBuilder: (context, index) =>
              Padding(padding: EdgeInsets.only(bottom: 20)),
          itemBuilder: (context, index) {
            final destination = controller.randomDestinations.value[index];
            return Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFECEFEF),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(1),
                    margin: EdgeInsets.all(3),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        destination.featureimage ?? '',
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error),
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: progress.expectedTotalBytes != null
                                  ? progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            destination.propertyname ?? 'Unknown',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            destination.price != null
                                ? '\$${destination.price}'
                                : 'Price not available',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

}

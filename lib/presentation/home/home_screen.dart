import 'package:FoGraph/presentation/home/controller/homescreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:FoGraph/routes/app_route.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: const Text('FoGraph'),

      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("destination").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Please Wait');
          }

          var docs = snapshot.data?.docs;

          if (docs == null || docs.isEmpty) {
            return const Text('No Data Available');
          }

          return SizedBox(
            height: screenheight*0.45,

            // Set the desired height of each item in the horizontal list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: docs.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot<Map<String, dynamic>> destination = docs[index];
                return Padding(
                  padding:EdgeInsets.symmetric(horizontal: screenwidth*0.01),
                  child: ProductItem(
                    featureimage: destination['feature_image'],
                    property_name: destination['property_name'],
                    city_name: destination['city'],
                  ),
                );
              },
            ),
          );
        },
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


class ProductItem extends StatelessWidget {
  final String featureimage;
  final String property_name;
  final String city_name;

  ProductItem({
    required this.featureimage,
    required this.property_name,
    required this.city_name,
  });

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    double containerWidth = screenwidth * 0.8;
    double imageSize = containerWidth;
    double boxHeight = screenheight * 0.13;
    double padding = 8.0;

    return Container(
      width: containerWidth,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              featureimage,
              fit: BoxFit.cover,
              width: imageSize,
              height: imageSize,
            ),
          ),
          Positioned(
            top: screenheight * 0.22,
            left: screenwidth * 0.035,
            width: screenwidth * 0.73,
            height: boxHeight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$property_name',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '$city_name',
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

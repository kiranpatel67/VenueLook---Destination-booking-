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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('FoGraph'),

      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("destination").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Please Wait');
          }

          var docs = snapshot.data?.docs;

          if (docs == null || docs.isEmpty) {
            return Text('No Data Available');
          }

          return SizedBox(
            height: 150.0, // Set the desired height of each item in the horizontal list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: docs.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot<Map<String, dynamic>> destination = docs[index];
                return ProductItem(
                  featureimage: destination['feature_image'],
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

  ProductItem({
    required this.featureimage
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0, // Set the desired width of each item in the horizontal list
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            featureimage,
            height: 100.0, // Set the desired height of the image
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

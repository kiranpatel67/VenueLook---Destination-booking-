import 'package:FoGraph/presentation/home/controller/homescreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:firebase_storage/firebase_storage.dart';


class HomeScreen extends StatelessWidget {
  final HomeScreenController controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: LogoWidget(),
        automaticallyImplyLeading: false, // Remove back arrow button
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

          // Separate the documents into lists based on the "type" field
          List<Map<String, dynamic>> type1List = [];
          List<Map<String, dynamic>> type2List = [];
          List<Map<String, dynamic>> type3List = [];

          docs.forEach((doc) {
            var data = doc.data();
            if (data.containsKey('type')) {
              int type = data['type'];
              if (type == 1) {
                type1List.add(data);
              } else if (type == 2) {
                type2List.add(data);
              } else if (type == 3) {
                type3List.add(data);
              }
            }
          });

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenheight*0.01),
                  child: _buildTypeListView(type3List, 'Budget Friendly Destination', context),
                ),
                _buildOffersGrid(context),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenheight*0.01),
                  child: _buildTypeListView(type1List, 'Top-notch Destinations', context),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenheight*0.01),
                  child: _buildTypeListView(type2List, 'Prime Destinations', context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTypeListView(List<Map<String, dynamic>> typeList, String title, BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    List<List<String>> propertyImagesList = [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: screenheight * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: typeList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> destination = typeList[index];
              List<String> propertyImages = destination['property_images']?.cast<String>() ?? []; // Ensure that property_images is a List<String>
              propertyImagesList.add(propertyImages);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                child: ProductItem(
                  featureimage: destination['feature_image'],
                  property_name: destination['property_name'],
                  city_name: destination['city'],
                  index: index,
                  propertyImagesList: propertyImagesList,
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  Widget _buildOffersGrid(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("offers").where('valid', isEqualTo: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Please Wait');
        }

        var docs = snapshot.data?.docs;

        if (docs == null || docs.isEmpty) {
          return const Text('No Offers Available');
        }

        // Display images in a 2x2 grid
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: docs.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Map<String, dynamic>? offer = docs[index].data() as Map<String, dynamic>?;

            // Check if offer is not null and contains the 'image_url' key
            if (offer != null && offer.containsKey('image_url')) {
              String imageUrl = offer['image_url'];

              return GestureDetector(
                onTap: () {
                  // Handle the tap on the offer image
                  // Add your logic here
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Display a default image if there is an error with the original image
                      return DefaultImageWidget();
                    },
                  ),
                ),
              );
            } else {
              // If 'image_url' is not present, you can return an empty container or some other default widget
              return Container();
            }
          },
        );
      },
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
  final int index;// Add property_images to store the array
  final List<List<String>> propertyImagesList;

  ProductItem({
    required this.featureimage,
    required this.property_name,
    required this.city_name,
    required this.index,
    required this.propertyImagesList
  });

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    double containerWidth = screenwidth * 0.8;
    double imageSize = containerWidth;
    double boxHeight = screenheight * 0.13;
    double padding = 8.0;

    return GestureDetector(
      onTap: () {
        // Pass the selected index and property_images to Request_Bookings page
        Get.toNamed(
          AppRoute.requestbooking,
          arguments: {
            'index': index,
            'property_images': propertyImagesList,
            'property_name' : property_name,
            'city': city_name,
          },
        );
      },
      child: SizedBox(
        width: containerWidth,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                featureimage,
                fit: BoxFit.cover,
                width: imageSize,
                height: screenheight*0.4,
                errorBuilder: (context, error, stackTrace) {
                  // Display a default image if there is an error with the original image
                  return DefaultImageWidget();
                },
              ),
            ),
            Positioned(
              top: screenheight * 0.25,
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
                        property_name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        city_name,
                        style: const TextStyle(
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
      ),
    );
  }
}

class DefaultImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey, // Set the background color of the default image
      width: double.infinity,
      height: double.infinity,
      child: const Center(
        child: Icon(
          Icons.error,
          color: Colors.white, // Set the color of the error icon
          size: 48.0,
        ),
      ),
    );
  }
}


class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double logosize = screenwidth * 0.08;
    return FutureBuilder(
      future: fetchLogoUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return const Text('Error loading logo');
        }

        String logoUrl = snapshot.data.toString();

        return Image.network(
          logoUrl,
          width: logosize, // Use logosize for the width
          height: logosize, // Use logosize for the height
        );
      },
    );
  }

  Future<String> fetchLogoUrl() async {
    String logoPath = 'FoGraph Logo.png';

    Reference ref = FirebaseStorage.instance.ref().child(logoPath);

    try {
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      rethrow;
    }
  }
}

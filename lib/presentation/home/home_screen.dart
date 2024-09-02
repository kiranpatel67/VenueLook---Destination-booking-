import 'dart:convert';

import 'package:FoGraph/presentation/home/controller/homescreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../Data_model/HomeScreen_data_model.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset('asset/img/fograph_logo.png', width: 10 ,height: 10,),
        ),
        automaticallyImplyLeading: false, // Remove back arrow button
        backgroundColor: Colors.grey[50],
        title: const Text('FoGraph'),
      ),
      body:
      FutureBuilder(
        future: getOffersStream(),
        builder: (context, AsyncSnapshot<List<HomeDestinationData>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 5, // Number of shimmer items
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row with one image occupying full width with rounded corners
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15.0), // Circular border
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // First row of grid items with rounded corners
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15.0), // Circular border
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15.0), // Circular border
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Second row of grid items with rounded corners
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15.0), // Circular border
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15.0), // Circular border
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          var docs = snapshot.data;

          if (docs == null || docs.isEmpty) {
            return const Text('No Data Available');
          }

          // Separate the documents into lists based on the "type" field
          List<HomeDestinationData> type1List = [];
          List<HomeDestinationData> type2List = [];
          List<HomeDestinationData> type3List = [];
          List<HomeDestinationData> type4List = docs;

          docs.forEach((doc) {
            var data = doc;
            if (data.type != null) {
              int type = data.type ?? 0;
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
            child: Column(
              children: [
                _buildTypeListView(
                  type3List,
                  'Budget Friendly Destination',
                  context,
                ),
                _buildOffersGrid(context),
                _buildTypeListView(
                  type1List,
                  'Top-notch Destinations',
                  context,
                ),
                _buildTypeListView(
                  type2List,
                  'Prime Destinations',
                  context,
                ),
                _buildExploreView(
                  type4List,
                  'Explore Destinations',
                  context,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _buildTypeListView(
      List<HomeDestinationData> typeList, String title, BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    List<List<String>> propertyImagesList = [];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(
            height: screenheight * 0.35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: typeList.length,
              itemBuilder: (context, index) {
                HomeDestinationData destination = typeList[index];
                List<String> propertyImages =
                    destination.propertyImages?.cast<String>() ??
                        []; // Ensure that property_images is a List<String>
                propertyImagesList.add(propertyImages);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                  child: ProductItem(
                    destination: destination,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreView(
      List<HomeDestinationData> typeList, String title, BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    List<List<String>> propertyImagesList = [];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: typeList.length,
            itemBuilder: (context, index) {
              HomeDestinationData destination = typeList[index];
              List<String> propertyImages =
                  destination.propertyImages?.cast<String>() ??
                      [];
              print(destination.propertyImages);
              propertyImagesList.add(propertyImages);
              return Padding(
                padding: EdgeInsets.fromLTRB(6, 0, 0, 20),
                child: SizedBox(
                  child: ProductItem(
                    destination : destination,
                    imageHeight: 200,
                    imageWidth: screenwidth,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOffersGrid(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("offers")
          .where('valid', isEqualTo: true)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Please Wait');
        }

        var docs = snapshot.data?.docs;

        if (docs == null || docs.isEmpty) {
          return const Text('No Offers Available');
        }

        // Display images in a 2x2 grid
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: docs.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Map<String, dynamic>? offer =
              docs[index].data() as Map<String, dynamic>?;

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
          ),
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

  final HomeDestinationData destination;
  final double? imageHeight;
  final double? imageWidth;

  const ProductItem({required this.destination,  this.imageHeight,  this.imageWidth});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    double containerWidth = screenwidth * 0.70;
    double imageSize = containerWidth;
    double boxHeight = screenheight * 0.16;
    double padding = 8.0;

    return GestureDetector(
      // onTap: () {
      //   // Pass the selected index and property_images to Request_Bookings page
      //   Get.toNamed(
      //     AppRoute.requestbooking,
      //     arguments: {
      //       'destination' : jsonEncode(destination.toMap())
      //       // 'index': index,
      //       // 'property_images': propertyImagesList,
      //       // 'property_name': property_name,
      //       // 'city': city_name,
      //       // 'price': price,
      //       // 'numberofhours': numberofhours,
      //       // 'property_Address': propertyAddress,
      //     },
      //   );
      // },
      onTap: () {
        // Ensure destination data is properly serialized
        Get.toNamed(
          AppRoute.requestbooking,
          arguments: {
            'destination': destination,
          },
        );
      },

      child: SizedBox(
        width: containerWidth,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22.0),
              child: Image.network(
                "${destination.featureimage}",
                fit: BoxFit.cover,
                width: imageWidth ?? imageSize,
                height: imageHeight ?? screenheight * 0.4,
                errorBuilder: (context, error, stackTrace) {
                  // Display a default image if there is an error with the original image
                  return DefaultImageWidget();
                },
              ),
            ),
            Positioned(
              bottom: 0,
              width: imageWidth ?? imageSize,
              height: boxHeight,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "${destination.propertyname}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          "${destination.city}",
                          style: const TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: Icon(
                                      Icons.access_time,
                                      size: 16.0,
                                    )),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  '${destination.hourlist?.first} ',
                                  style: TextStyle(fontSize: 12.0),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 16.0,
                                ),
                                Container(
                                    padding: EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: Icon(
                                      Icons.attach_money,
                                      size: 16.0,
                                    )),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  '₹$_modifyPrice',
                                  style: TextStyle(fontSize: 12.0),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _modifyPrice {
    return (destination.price! + (destination.price! * 8 / 100)).toString();
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

// class LogoWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double screenwidth = MediaQuery.of(context).size.width;
//     double logosize = screenwidth * 0.06;
//     return FutureBuilder(
//       future: fetchLogoUrl(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }
//
//         if (snapshot.hasError) {
//           return const Text('Error loading logo');
//         }
//
//         String logoUrl = snapshot.data.toString();
//
//         return Image.network(
//           logoUrl,
//           width: logosize, // Use logosize for the width
//           height: logosize, // Use logosize for the height
//         );
//       },
//     );
//   }
//
//   Future<String> fetchLogoUrl() async {
//     String logoPath = 'FoGraph Logo.png';
//
//     Reference ref = FirebaseStorage.instance.ref().child(logoPath);
//
//     try {
//       String downloadURL = await ref.getDownloadURL();
//       return downloadURL;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
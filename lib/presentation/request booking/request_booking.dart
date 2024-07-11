// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:FoGraph/Data_model/HomeScreen_data_model.dart';
//
// import '../../Data_model/Request_data_model.dart';
//
//
// class RequestBookings extends StatefulWidget {
//   const RequestBookings({super.key});
//
//   @override
//   _RequestBookingsState createState() {
//     return _RequestBookingsState();
//   }
// }
//
// class _RequestBookingsState extends State<RequestBookings> {
//    HomeDestinationData? destination;
//   RequestBookingData? bookingData;
//
//   @override
//
//   Widget build(BuildContext context) {
//
//
//
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Background image
//           PageView.builder(
//             controller: _pageController,
//             itemCount: destination?.propertyImages?.length,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentPage = index;
//               });
//               if (index == (destination?.propertyImages!.length ?? 0) - 1) {
//                 // Last page is reached, jump back to the first page
//                 _pageController.jumpToPage(0);
//               }
//             },
//             itemBuilder: (context, imageIndex) {
//               String? imageUrl = destination?.propertyImages?[imageIndex];
//               return Image.network(
//                 imageUrl ?? '',
//                 fit: BoxFit.cover,
//               );
//             },
//           ),
//           // Light overlay
//           Container(
//             color: Colors.black.withOpacity(0.3), // Adjust the opacity as needed
//           ),
//           // Dots indicator
//           Positioned(
//             top: screenheight * 0.06,
//             right: screenwidth * 0.05,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: List.generate(
//                 destination?.propertyImages!.length ?? 0,
//                     (index) => Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                   width: screenwidth*0.03,
//                   height: screenheight*0.015,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: _currentPage == index ? Colors.white : Colors.grey,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Flexible(
//             child: Padding(
//               padding: EdgeInsets.only(top: screenheight*0.25),
//               child: Column(
//                 children: [
//                   Text(
//                     '${destination?.propertyname}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w900,
//                       fontSize: 40.0,
//                     ),
//                     overflow: TextOverflow.clip, // Allow text to overflow and wrap to the next line
//                   ),
//                   SizedBox(height:  screenheight*0.015),
//                   Align(
//                     alignment: Alignment.bottomLeft,
//                     child: Text(
//                       '${destination?.city}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                       ), // Allow text to overflow and wrap to the next line
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ).paddingSymmetric(horizontal: screenwidth * 0.02),
//
//           SlidingUpPanel(
//             minHeight: screenheight * 0.08,
//             maxHeight: screenheight * 0.8,
//
//             borderRadius:  const BorderRadius.only(
//               topLeft: Radius.circular(22.0),
//               topRight: Radius.circular(22.0),
//             ),
//             panel:  Column(
//               children: [
//                 Text('${bookingData?.description}'),
//                 Text('${bookingData?.property_address}'),
//                 Text('${bookingData?.destination_policy}'),
//
//               ],
//             ),
//             collapsed: Container(
//               padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//               decoration:  const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(22.0),
//                   topRight: Radius.circular(22.0),
//                 ),
//                 color: Colors.green,
//               ),
//               child:  Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '₹${destination?.price}',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.0),
//
//                       ),
//                       Text(
//                         'for ${destination?.hourlist?.first} hour(s) ',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.0),
//                       ),
//
//                     ],
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Text(
//                       "REQUEST BOOKING",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: screenheight * 0.02
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//             ),
//
//           ),
//         ],
//       ),
//     );
//     // Check if args are not null and contain the required information
//    /* if (args != null && args.containsKey('destination')) {
//       // final int index = args['index'] as int;
//       // final List<List<String>> propertyImagesList = args['property_images'] as List<List<String>>;
//       // final String property = args['property_name'] as String;
//       // final String cityName = args['city'] as String;
//       // final double price = args['price'] as double;
//       // final String numberofhours= args['numberofhours'] as String;
//
//
//     } else {
//       // Handle the case where args are null or don't contain the required information
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Error'),
//         ),
//         body: const Center(
//           child: Text('Invalid arguments'),
//         ),
//       );
//     }*/
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
// }
//
//

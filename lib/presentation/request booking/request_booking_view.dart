import 'package:FoGraph/routes/app_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'controller/requestbooking_controller.dart';

class RequestBookingsPage extends GetView<RequestBookingsController> {
  @override
  Widget build(BuildContext context) {
    RequestBookingsController controller = Get.find();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          PageView.builder(
            controller: controller.pageController.value,
            itemCount: controller.destination.value?.propertyImages?.length,
            onPageChanged: (index) {
              if (index ==
                  (controller.destination.value?.propertyImages!.length ?? 0) -
                      1) {
                // Last page is reached, jump back to the first page
                controller.pageController.value.jumpToPage(0);
              }
            },
            itemBuilder: (context, imageIndex) {
              String? imageUrl =
                  controller.destination.value?.propertyImages?[imageIndex];
              return Image.network(
                imageUrl ?? '',
                fit: BoxFit.cover,
              );
            },
          ),
          // Light overlay
          Container(
            color:
                Colors.black.withOpacity(0.3), // Adjust the opacity as needed
          ),
          // Dots indicator
          Positioned(
            top: Get.height * 0.06,
            right: Get.width * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(
                controller.destination.value?.propertyImages!.length ?? 0,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: Get.width * 0.03,
                  height: Get.height * 0.015,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.currentPage == index
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: Get.height * 0.25),
              child: Column(
                children: [
                  Text(
                    '${controller.destination.value?.propertyname}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 40.0,
                    ),
                    overflow: TextOverflow
                        .clip, // Allow text to overflow and wrap to the next line
                  ),
                  SizedBox(height: Get.height * 0.015),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '${controller.destination.value?.city}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ), // Allow text to overflow and wrap to the next line
                    ),
                  ),
                ],
              ),
            ),
          ).paddingSymmetric(horizontal: Get.width * 0.02),

          SlidingUpPanel(
            minHeight: Get.height * 0.08,
            maxHeight: Get.height * 0.8,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(22.0),
              topRight: Radius.circular(22.0),
            ),
            panel: Obx(() {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 35),
                      Text(
                        'About this destination',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${controller.bookingData.value?.description}',
                        style: TextStyle(color: Color(0xFF71797E)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Address',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${controller.bookingData.value?.property_address}',
                        style: TextStyle(color: Color(0xFF71797E)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                      color: Colors.green, width: 0.5),
                                ),
                              ),
                              onPressed: () {
                                controller.launchURL(
                                    controller.bookingData.value?.latlng);
                              },
                              child: Text(
                                'VIEW ON MAP',
                                style: TextStyle(color: Colors.green),
                              ))),
                      Text(
                        'This destination allows',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: 20,
                        height: 10,
                      ),
                      Text(
                        '${controller.bookingData.value?.destination_policy?.join('\n')}',
                        style: TextStyle(color: Color(0xFF71797E)),
                      ),
                      SizedBox(
                        width: 20,
                        height: 30,
                      ),
                      Text(
                        'Image gallery',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 250.0,
                          autoPlay: true,
                          reverse: true,
                          enlargeCenterPage: true,
                        ),
                        items: controller.destination.value?.propertyImages
                                ?.map((imageUrl) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(imageUrl,
                                          fit: BoxFit.cover),
                                    ), // Create an Image.network for each URL
                                  );
                                },
                              );
                            }).toList() ??
                            [],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Center(
                          child: AnimatedSmoothIndicator(
                            activeIndex: controller.currentPage,
                            count: controller.destination.value?.propertyImages
                                    ?.length ??
                                0,
                            effect: WormEffect(
                              dotWidth: 10,
                              dotHeight: 10,
                              activeDotColor: Colors.blue,
                              dotColor: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
            header: Obx(() {
              return Container(
                width: Get.width,
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.0),
                    topRight: Radius.circular(22.0),
                  ),
                  color: Colors.green,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${controller.destination.value?.price}',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        Text(
                          'for ${controller.destination.value?.hourlist?.first} hour(s) ',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  color: Colors.green.shade700,
                                  width:
                                      0.5), // Change this value to reduce the border radius
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(AppRoute.destinationbookingpage,
                                arguments: {
                                  'destination': controller.destination.value
                                });
                          },
                          child: Text(
                            "REQUEST BOOKING",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )),
                  ],
                ),
              );
            }),
            collapsed: Obx(() {
              return Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.0),
                    topRight: Radius.circular(22.0),
                  ),
                  color: Colors.green,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${controller.destination.value?.price}',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        Text(
                          'for ${controller.destination.value?.hourlist?.first} hour(s) ',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.green, width: 1),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(AppRoute.destinationbookingpage,
                                arguments: {
                                  'destination': controller.destination.value,
                                  'bookingdata': controller.bookingData.value
                                });
                          },
                          child: Text(
                            "REQUEST BOOKING",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

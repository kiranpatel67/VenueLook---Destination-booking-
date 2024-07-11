import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'controller/requestbooking_controller.dart';

class RequestBookingsPage extends GetView<RequestBookingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          PageView.builder(
            controller: controller.pageController.value,
            itemCount: controller.destination.value?.propertyImages?.length,
            onPageChanged: (index) {
              controller.currentPage.value = index;
              if (index == (controller.destination.value?.propertyImages!.length?? 0) - 1) {
                // Last page is reached, jump back to the first page
                controller.pageController.value.jumpToPage(0);
              }
            },
            itemBuilder: (context, imageIndex) {
              String? imageUrl = controller.destination.value
                  ?.propertyImages?[imageIndex];
              return Image.network(
                imageUrl ?? '',
                fit: BoxFit.cover,
              );
            },
          ),
          // Light overlay
          Container(
            color: Colors.black.withOpacity(
                0.3), // Adjust the opacity as needed
          ),
          // Dots indicator
          Positioned(
            top: Get.height * 0.06,
            right: Get.width * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(
                controller.destination.value?.propertyImages!.length ?? 0,
                    (index) =>
                    Container(
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
              return Column(
                children: [
                  Text('${controller.bookingData.value?.description}'),
                  Text('${controller.bookingData.value?.property_address}'),
                  Text('${controller.bookingData.value?.destination_policy}'),

                ],
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
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0),

                        ),
                        Text(
                          'for ${controller.destination.value?.hourlist
                              ?.first} hour(s) ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0),
                        ),

                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "REQUEST BOOKING",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.height * 0.02
                        ),
                      ),
                    ),
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
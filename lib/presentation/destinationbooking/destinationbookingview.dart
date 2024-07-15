import 'package:FoGraph/presentation/destinationbooking/detinationbookingController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class DestinationbookingPage extends GetView<DestinationBookingController> {
  DestinationbookingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'ForGraph Destination Booking',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Book Sapce for Photo Shoot At',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                '${controller.destination.value?.propertyname}',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(height: 25),
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8, color: Colors.black),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: GestureDetector(
                  onTap: () {
                    _showDatePicker();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            Image.asset(
                              'asset/img/selectdateicon.jpeg',
                              width: 18,
                              height: 18,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                'Select Date',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                            () => Padding(
                          padding: const EdgeInsets.fromLTRB(20, 6, 0, 0),
                          child: Text(
                            '${controller.selectedDate.value}',
                            style: TextStyle(
                              fontSize: 20,
                                color: Color(0xFF71797E)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8, color: Colors.black),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Obx(() {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                Image.asset(
                                  'asset/img/selectimageicon.png',
                                  width: 17,
                                  height: 17,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Text(
                                    'Select Hours',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      
                          Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Row(
                              children: controller.destination.value?.hourlist?.map((hour) {
                                return Row(
                                  children: [
                                    Obx(
                                          () => Radio(
                                        value: hour,
                                        groupValue: controller.selectedHour.value,
                                        onChanged: (value) {
                                          controller.setSelectedHour(value as String);
                                        },
                                      ),
                                    ),
                                    Text(hour),
                                  ],
                                );
                              }).toList()?? [],
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
              SizedBox(height: 25),
              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  children: [
                    Text('TOTAL PRICE',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Text(
                      '₹ ${controller.destination.value?.price}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.green),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.green,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      controller.saveData();
                      print('hi');
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Text(
                            'REQUEST BOOKING  ₹ ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  )),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                    child: Text(
                      'and pay ₹   at Destination later',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF343434),
                      ),
                    ),
                  ),
                  Text(
                    'Note: Booking amount will be refunded if Booking request is cancelled or not approved by the owner',
                    style: TextStyle(color: Color(0xFF71797E)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<Null>  _showDatePicker() {
     return showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    ).then((value) {
      if (value != null) {
        controller.setSelectedDate(value.toString().split(' ').first);
      }
    });
  }
}

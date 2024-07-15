import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Data_model/HomeScreen_data_model.dart';
import '../../../Data_model/requestBookingData_model.dart';

class RequestBookingsController extends GetxController {
  Rx<PageController> pageController = Rx<PageController>(PageController());
  Rx<HomeDestinationData?> destination = Rx<HomeDestinationData?>(null);
  Rx<RequestBookingData?> bookingData = Rx<RequestBookingData?>(null);

  void onInit() {
    super.onInit();
    destination.value = Get.arguments?['destination'];
    startAutomaticPageChange();
    getData();
  }

  @override
  void onClose() {
    pageController.value.dispose();
  }

  RxInt _currentPage = 0.obs;

  int get currentPage => _currentPage.value;

  void updateCurrentPage(int index) {
    _currentPage.value = index;
  }

  launchURL(GeoPoint? points) async {
    const String homeLat = "37.3230";
    const String homeLng = "-122.0312";

    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=${points?.longitude},${points?.latitude}";

    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }

  void startAutomaticPageChange() {
    Future.delayed(const Duration(seconds: 3), () {
      if (currentPage < pageController.value.page! + 1) {
        // Move to the next page
        pageController.value.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else {
        // Go back to the first page
        pageController..value.jumpToPage(0);
      }
      startAutomaticPageChange();
    });
  }

  getData() async {
    try {
      final Map<String, dynamic>? args = Get.arguments as Map<String, dynamic>?;

      print("image are" + "${destination.value?.id}");
      if (destination.value?.id != null) {
        bookingData.value =
            await getDestionationDetails(id: destination.value?.id);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}

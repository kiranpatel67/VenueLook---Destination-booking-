import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../Data_model/HomeScreen_data_model.dart';
import '../../../Data_model/requestBookingData_model.dart';

class BookingsController extends GetxController {
  Rx<HomeDestinationData?> destination = Rx<HomeDestinationData?>(null);
  Rx<RequestBookingData?> bookingData = Rx<RequestBookingData?>(null);
  var selectedIndex = 1.obs;
  void changeTabIndex(int index) {
    selectedIndex.value = index;
    destination.value = Get.arguments?['destination'];
    bookingData.value = Get.arguments?['bookingdata'];
  }


  final RxInt selectedsubtabIndex = 0.obs;

  void changesubTabIndex(int index) {
    selectedsubtabIndex.value = index;
  }

}

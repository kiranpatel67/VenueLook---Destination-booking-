import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../Data_model/BookingDetails.dart';
import '../../../Data_model/HomeScreen_data_model.dart';
import '../../../Data_model/requestBookingData_model.dart';

class BookingsController extends GetxController {
  RxList<HomeDestinationData> randomDestinations = <HomeDestinationData>[].obs;
  Rx<RequestBookingData?> bookingData = Rx<RequestBookingData?>(null);
  var selectedIndex = 1.obs;
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
  @override
  void onInit() {
    super.onInit();
    fetchDestinations();
  }


  void fetchDestinations() async {
    List<HomeDestinationData> allDestinations = await getOffersStream();
    randomDestinations.value = _selectRandomDestinations(allDestinations, 6);
  }

  List<HomeDestinationData> _selectRandomDestinations(List<HomeDestinationData> list, int count) {
    final random = Random();
    List<HomeDestinationData> selectedDestinations = [];
    Set<int> selectedIndices = {};

    while (selectedDestinations.length < count && selectedIndices.length < list.length) {
      int randomIndex = random.nextInt(list.length);
      if (!selectedIndices.contains(randomIndex)) {
        selectedIndices.add(randomIndex);
        selectedDestinations.add(list[randomIndex]);
      }
    }

    return selectedDestinations;
  }

  final RxInt selectedsubtabIndex = 0.obs;

  void changesubTabIndex(int index) {
    selectedsubtabIndex.value = index;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../Data_model/HomeScreen_data_model.dart';
import '../../../Data_model/requestBookingData_model.dart';

class DestinationBookingController extends GetxController {
  Rx<HomeDestinationData?> destination = Rx<HomeDestinationData?>(null);
  Rx<RequestBookingData?> bookingData = Rx<RequestBookingData?>(null);
  RxString selectedHour = ''.obs;
  RxList<String> hourlist = RxList<String>([]);
  RxString selectedDate = ''.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final currentIndex = 0.obs;
  void setSelectedDate(String value) {
    selectedDate.value = value;
  }

  void setSelectedHour(String value) {
    selectedHour.value = value;
  }


  @override
  void onInit() {
    super.onInit();
    destination.value = Get.arguments?['destination'];
  }

  void saveData() {
    CollectionReference dest = _firestore
        .collection('destination')
        .doc(destination.value?.id)
        .collection("bookings");
    dest.add({
      'booking_date_digit': '',
      'booking_hours': destination.value?.hourlist,
      'booking_id': Uuid().v4(),
      'booking_initiated_date': '19-12-2019 04:55:20',
      'booking_price': destination.value?.price,
      'booking_status': destination.value?.status,
      'cancellation_reason': null,
      'checkin_time': null,
      'coupon_code': '',
      'destination_id': destination.value?.id,
      'feature_image': destination.value?.propertyImages,
      'latlng': bookingData.value?.latlng,
      'payLaterPrice': 1000,
      'payment_status': destination.value?.status,
      'property_address': destination.value?.propertyAddress,
      'property_city': destination.value?.city,
      'property_name': destination.value?.propertyname,
      'property_phone': null,
      'property_state': '',
      'refund_amount': 0,
      'refund_status': 0,
      'user_email': destination.value?.manageremail,
      'user_name': destination.value?.managername,
      'user_phone': destination.value?.managerphoneno,
      'user_id': auth.currentUser?.uid
    }).catchError((error) {
      print("Failed to create document in destination collection: $error");
    });
  }
}

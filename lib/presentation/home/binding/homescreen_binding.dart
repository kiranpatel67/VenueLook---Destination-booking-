import 'package:FoGraph/presentation/home/controller/homescreen_controller.dart';
import 'package:get/get.dart';

import '../../profile/controller/profile_controller.dart';
import '../../request booking/controller/requestbooking_controller.dart';

class HomeScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
    // loads data before
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<RequestBookingsController>(() => RequestBookingsController());
    // fenix available to other screens
  }

}
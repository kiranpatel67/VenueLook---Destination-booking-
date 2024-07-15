import 'package:FoGraph/presentation/destinationbooking/detinationbookingController.dart';
import 'package:get/get.dart';

class DestinationBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DestinationBookingController>(() => DestinationBookingController());
  }
}

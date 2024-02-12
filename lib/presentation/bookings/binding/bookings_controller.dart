import 'package:FoGraph/presentation/bookings/controller/bookings_controller.dart';
import 'package:get/get.dart';

class BookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BookingsController());
  }
}

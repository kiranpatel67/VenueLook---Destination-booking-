import 'package:get/get.dart';
import '../controller/requestbooking_controller.dart';

class RequestBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestBookingsController>(() => RequestBookingsController());
  }
}

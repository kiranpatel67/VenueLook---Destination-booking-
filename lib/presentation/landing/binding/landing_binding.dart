import 'package:FoGraph/presentation/landing/controller/landing_controller.dart';
import 'package:get/get.dart';

class LandingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LandingController());
    // loads data before
    // fenix available to other screens
  }

}
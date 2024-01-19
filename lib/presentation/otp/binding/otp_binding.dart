import 'package:FoGraph/presentation/otp/controller/otp_controller.dart';
import 'package:get/get.dart';

class OTPBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OTPController());
    // fenix available to other screens
  }

}
import 'package:FoGraph/presentation/destinationbooking/detinationbookingController.dart';
import 'package:FoGraph/presentation/signupscreen/SignupController.dart';
import 'package:get/get.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Signupcontroller>(() => Signupcontroller());
  }
}

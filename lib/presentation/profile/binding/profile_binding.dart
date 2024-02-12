import 'package:FoGraph/presentation/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
    // loads data before
    // fenix available to other screens
  }

}
import 'package:FoGraph/presentation/login/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    // loads data before
    // fenix available to other screens
  }

}
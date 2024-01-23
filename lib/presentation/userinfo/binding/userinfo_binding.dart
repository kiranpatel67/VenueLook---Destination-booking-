import 'package:FoGraph/presentation/login/controller/login_controller.dart';
import 'package:FoGraph/presentation/userinfo/controller/userinfo_controller.dart';
import 'package:get/get.dart';

class UserInfoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => UserInfoController());
    // loads data before
    // fenix available to other screens
  }

}
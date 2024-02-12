import 'package:FoGraph/presentation/home/controller/homescreen_controller.dart';
import 'package:get/get.dart';

class HomeScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
    // loads data before
    // fenix available to other screens
  }

}
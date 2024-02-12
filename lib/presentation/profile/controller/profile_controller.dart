import 'package:get/get.dart';

class ProfileController extends GetxController {

  var selectedIndex = 2.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}

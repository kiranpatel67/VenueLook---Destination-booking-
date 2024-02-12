import 'package:get/get.dart';

class BookingsController extends GetxController {
  var selectedIndex = 1.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }


  final RxInt selectedsubtabIndex = 0.obs;

  void changesubTabIndex(int index) {
    selectedsubtabIndex.value = index;
  }
}

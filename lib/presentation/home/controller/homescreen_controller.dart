import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final List<RxList<String>> horizontalLists = <RxList<String>>[];
  final List<List<String>> locations = [
    [
      'Paris, France',
      'New York City, USA',
      'Tokyo, Japan',
      'Delhi, India',
      'Additional Destination',
    ],
    [
      'Rome, Italy',
      'Sydney, Australia',
      'London, UK',
    ],
    [
      'Barcelona, Spain',
      'Dubai, UAE',
      'Cape Town, South Africa',
      'Addition',
      'Addition',
      'Addition',
    ],
  ];
  final List<List<String>> cities = [
    ['Paris', 'New York City', 'Tokyo', 'Delhi'],
    ['Rome', 'Sydney', 'London'],
    ['Barcelona', 'Dubai', 'Cape Town', 'City1', 'City2', 'City3'],
  ];
  final List<String> destinationCodes = [
    'paris_france',
    'new_york_city',
    'tokyo_japan',
    'delhi_india',
    'additional_destination',
    'rome_italy',
    'sydney_australia',
    'london_uk',
    'barcelona_spain',
    'dubai_uae',
    'cape_town_south_africa',
    'city1_code',
    'city2_code',
    'city3_code',
  ];

  @override
  void onInit() {
    super.onInit();
    loadLists();
  }

  void loadLists() {
    RxList<String> list1 = locations[0].obs;
    RxList<String> list2 = locations[1].obs;
    RxList<String> list3 = locations[2].obs;

    horizontalLists.addAll([list1, list2, list3]);
  }

  final RxInt selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}

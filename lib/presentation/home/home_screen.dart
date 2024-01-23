import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final List<RxList<String>> horizontalLists = List.generate(3, (_) => <String>[].obs);

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < horizontalLists.length; i++) {
      horizontalLists[i].addAll(List.generate(10, (index) => 'Item ${index + 1}'));
    }
  }
}

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('FoGraph',
        style: TextStyle(
          fontSize: 15
        ),
        ),
      ),
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildHorizontalListView("Top Notch Destinations", controller.horizontalLists[0]),
            buildHorizontalListView("Prime Destinations", controller.horizontalLists[1]),
            buildHorizontalListView("Budget Friendly Destinations", controller.horizontalLists[2]),
          ],
        ),
      ),
    );
  }

  Widget buildHorizontalListView(String heading, RxList<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            heading,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 200, // Set the desired height for each row
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
                  () => Row(
                children: List.generate(
                  items.length,
                      (index) => buildListItem(items[index]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildListItem(String item) {
    return Container(
      width: 200, // Set the desired width for each item
      height: 180, // Set the desired height for each item
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          item,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class GreenButtonController extends GetxController {
  final RxBool isButtonEnabled = true.obs;
}

class GreenButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  GreenButton({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<GreenButtonController>(
      init: GreenButtonController(),
      builder: (controller) => InkWell(
        onTap: controller.isButtonEnabled.value ? onPressed : null,
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            color: controller.isButtonEnabled.value ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(screenHeight * 0.015),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenHeight * 0.023,
            ),
          ),
        ),
      ),
    );
  }
}

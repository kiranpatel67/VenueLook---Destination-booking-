import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OTPController extends GetxController {
  // final TextEditingController textEditingController = TextEditingController();

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('This app is only available in India'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
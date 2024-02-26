import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:FoGraph/presentation/userinfo/user_information.dart';

class LoginController extends GetxController {
  final RxBool animationPlayed = false.obs;
  // final TextEditingController textEditingController = TextEditingController();
  RxString phoneNumber = ''.obs;
  RxBool showLinearProgress = false.obs;
  late Rx<UserInformation?> userInformation;

  void setUserInformation(UserInformation information) {
    userInformation.value = information;
  }

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('This app is only available in India'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
  void setPhoneNumber(String number) {
    phoneNumber.value = number;
  }
  void setShowLinearProgress(bool value) {
    showLinearProgress.value = value;
  }
}
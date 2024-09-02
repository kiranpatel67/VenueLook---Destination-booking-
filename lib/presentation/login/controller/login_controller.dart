import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_route.dart';

class LoginController extends GetxController {
  final RxBool animationPlayed = false.obs;

  // final TextEditingController textEditingController = TextEditingController();

  RxString phoneNumber = ''.obs;

  void savePhonenumberToStorage() {
    GetStorage().write('phonenumber', phoneNumber.value);
  }
  RxBool showLinearProgress = false.obs;

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

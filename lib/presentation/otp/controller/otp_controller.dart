
import 'package:FoGraph/routes/app_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:FoGraph/core/service/auth_service.dart';
import 'package:get_storage/get_storage.dart';

class OTPController extends GetxController {

   late String verificationId;
  late String otp;
  RxBool isOtpReceived = false.obs;
  late RxString userInformation = ''.obs;

  void setUserInformation(String information) {
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
@override
  void onInit() {
  verificationId = Get.arguments?['verificationId'] ?? '';
    super.onInit();
  }
  void otpReceived() {
    isOtpReceived.value = true;
  }

  void setVerificationId(String id) {
    verificationId = id;
  }

  void setOtp(String enteredOtp) {
    otp = enteredOtp;
    print('otp is${otp}');
  }
}

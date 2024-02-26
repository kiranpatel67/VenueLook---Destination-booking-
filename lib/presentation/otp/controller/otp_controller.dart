import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:FoGraph/core/service/auth_service.dart';

class OTPController extends GetxController {

  late String verificationId;
  late String otp;
  RxBool isOtpReceived = false.obs;
  late RxString userInformation = ''.obs;

  // Other methods and logic in your controller...

  // Example method to set userInformation
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

  void otpReceived() {
    isOtpReceived.value = true;
  }

  void setVerificationId(String id) {
    verificationId = id;
  }

  void setOtp(String enteredOtp) {
    otp = enteredOtp;
  }
}


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FoGraph/presentation/login/controller/login_controller.dart';
import 'package:FoGraph/presentation/otp/controller/otp_controller.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:FoGraph/presentation/userinfo/controller/userinfo_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Data_model/Profile_data_model.dart';
class AuthService1 {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final LoginController loginController = Get.find();
  final OTPController otpController = Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserInfoController userInfoController = Get.put(UserInfoController());

  Future<void> checkPhoneNumberInFirestoreAndNavigate() async {
    String phonenumber = loginController.phoneNumber.value;
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: phonenumber)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
          await signInWithPhoneNumber(phonenumber);
      } else {
        Get.snackbar('Error', 'Phone number not found. Please sign up.');
        Get.toNamed(AppRoute.Signuppage);
      }
    } catch (e) {
      print('Error checking phone number: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.');
    }
  }


  FirebaseAuth auth = FirebaseAuth.instance;
  var verificationId = ''.obs;

  void setVerificationId(String id) {
    verificationId.value = id;
  }

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithCredential(credential);
          Get.toNamed(AppRoute.otpPage);
        } catch (e) {
          Get.snackbar('Error', 'Sign-in failed: ${e.toString()}');
        }
      },
      verificationFailed: (FirebaseAuthException e) async {
        if (e.code == 'auth/too-many-requests') {
          print('Quota exceeded. Trying again with a delay...');
          await Future.delayed(Duration(seconds: 10)); // Wait for 10 seconds
          signInWithPhoneNumber(phoneNumber);
        } else {
          Get.snackbar('Error', e.message ?? 'Verification failed');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        setVerificationId(verificationId);
        print('Verification ID received: $verificationId');
        Get.toNamed(AppRoute.otpPage, arguments: {'verificationId': verificationId});
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Auto retrieval timeout. Verification ID: $verificationId');
      },
      forceResendingToken: null,
    );
  }

  Future<bool> verifyOtp() async {
    if (verificationId != null && otpController != null) {
      try {
        print('Attempting OTP verification...');
        print('Verification ID: ${verificationId.value}');
        print('Entered OTP: ${otpController.otp}');

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId.value,
          smsCode: otpController.otp,
        );

        UserCredential userCredential = await _auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          String? userToken = await user.getIdToken();
          if (userToken != null) {
            print('User token: $userToken');
            return true;
          } else {
            Get.snackbar('Error', 'Invalid OTP');
            return false;
          }
        } else {
          Get.snackbar('Error', 'Failed to get current user');
          return false;
        }
      } catch (e) {
        print('Exception during OTP verification: ${e.toString()}');
        Get.snackbar('Error', 'OTP verification failed: ${e.toString()}');
        return false;
      }
    } else {
      Get.snackbar('Error', 'Please enter a valid OTP');
      return false;
    }
  }



Future<void> handleOtpVerification() async {
  final Map<String, dynamic> arguments = Get.arguments;
  final String verificationId = arguments['verificationId'];
    bool success = await verifyOtp();
    if (success) {
      // You can perform additional actions if needed
      print('OTP verification successful');
      Get.toNamed(AppRoute.homePage);
    } else {
      // Handle failure case
      print('OTP verification failed');
    }
  }
}


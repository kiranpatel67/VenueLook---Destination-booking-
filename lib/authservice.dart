import 'package:FoGraph/routes/app_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AuthService2 {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> verifyOtp(String phoneNumber, String enteredOtp) async {
    try {
      // Get the verification ID from wherever you stored it during the login process
      // For example, if you're using Firebase phone authentication, you'd store it in the verificationCompleted callback
      String verificationId = ""; // Replace with the actual verification ID

      // Create PhoneAuthCredential using the verification ID and entered OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: enteredOtp,
      );

      // Sign in with the PhoneAuthCredential
      await _auth.signInWithCredential(credential);

      // If signInWithCredential is successful, return true
      return true;
    } catch (e) {
      // If an error occurs during OTP verification, return false
      print("Error verifying OTP: $e");
      return false;
    }
  }

}

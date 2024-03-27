import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FoGraph/presentation/login/controller/login_controller.dart';
import 'package:FoGraph/presentation/otp/controller/otp_controller.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:FoGraph/presentation/userinfo/controller/userinfo_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final LoginController loginController = Get.find();
  final OTPController otpController = Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserInfoController userInfoController = Get.put(UserInfoController());


  // ... other methods
  Future<bool> checkPhoneNumberInFirestore(String phoneNumber) async {
    try {
      // Query Firestore collection to check if the phone number exists
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('phone', isEqualTo: phoneNumber)
          .get();

      // If there are any documents, the phone number exists
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking phone number in Firestore: $e');
      return false; // Return false in case of an error
    }
  }
  Future<void> createUserProfile() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Update user profile with additional information
        await user.updateProfile(displayName: userInfoController.name.value);

        // Save additional user information to Firestore or your preferred database
        // For simplicity, you can print them for now
        print('User Name: ${user.displayName}');
        print('User Email: ${user.email}');
      }
    } catch (e) {
      print(e.toString());
    }
  }



  Future<void> verifyPhone() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91${loginController.phoneNumber}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        otpController.setVerificationId(verificationId);
        Get.toNamed(AppRoute.otpPage);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

// ... (Previous code)


// ... (Remaining code)


  Future<bool> verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: otpController.verificationId,
        smsCode: otpController.otp,
      );

      // Send the OTP to Firebase for verification
      await _auth.signInWithCredential(credential);

      // After successful OTP verification, perform additional actions
      User? user = _auth.currentUser;
      if (user != null) {
        // Fetch additional user information if needed
        String? userToken = await user.getIdToken();
        if (userToken != null) {
          // Perform actions with user information
          print('User token: $userToken');
          // Save user information or perform desired actions
          return true; // Indicate that OTP verification was successful
        } else {
          // Handle the case where userToken is null
          return false; // Indicate that OTP verification failed
        }
      } else {
        return false; // Indicate that OTP verification failed
      }
    } catch (e) {
      print(e.toString());
      return false; // Indicate that OTP verification failed
    }
  }



}

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FoGraph/presentation/login/controller/login_controller.dart';
import 'package:FoGraph/presentation/otp/controller/otp_controller.dart';
import 'package:FoGraph/routes/app_route.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final LoginController loginController = Get.find();
  final OTPController otpController = Get.find();

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

  Future<bool> verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: otpController.verificationId,
        smsCode: otpController.otp,
      );

      UserCredential authResult = await _auth.signInWithCredential(credential);
      String? userToken = await authResult.user?.getIdToken();

      if (userToken != null) {
        // saveLogin(userToken);
        print('User token: $userToken');
        // Go to the next page or perform the desired action
        return true; // Indicate that OTP verification was successful
      } else {
        // Handle the case where userToken is null
        return false; // Indicate that OTP verification failed
      }
    } catch (e) {
      print(e.toString());
      // Handle exceptions
      return false; // Indicate that OTP verification failed
    }
  }

}

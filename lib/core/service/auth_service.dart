import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FoGraph/presentation/login/controller/login_controller.dart';
import 'package:FoGraph/presentation/otp/controller/otp_controller.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:FoGraph/presentation/userinfo/controller/userinfo_controller.dart';
import 'package:FoGraph/presentation/userinfo/user_information.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final LoginController loginController = Get.find();
  final OTPController otpController = Get.find();

  final UserInfoController userInfoController = Get.put(UserInfoController());


  // ... other methods

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

  Future<User?> signInWithOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: otpController.verificationId,
        smsCode: otpController.otp,
      );

      UserCredential authResult = await _auth.signInWithCredential(credential);
      User? user = authResult.user;

      if (user != null) {
        // Store user information (name, email, etc.) in your user model or in a separate class
        // For simplicity, let's assume you have a User model
        UserInformation userInformation = UserInformation(
          name: 'John Doe', // Replace with the actual name
          email: 'john.doe@example.com', // Replace with the actual email
          phoneNumber: user.phoneNumber ?? '', // Get the phone number from the user object
        );

        // Save user information for future use
        loginController.setUserInformation(userInformation);
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// ... (Remaining code)


  Future<bool> verifyOtp() async {
    try {
      User? user = await signInWithOTP();

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

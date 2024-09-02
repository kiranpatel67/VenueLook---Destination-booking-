import 'package:FoGraph/core/extensions/padding_extension.dart';
import 'package:FoGraph/core/service/auth_service.dart';
import 'package:FoGraph/presentation/login/controller/login_controller.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_button.dart';
import '../../utils/constant/app_textstyles.dart';
import '../otp/controller/otp_controller.dart';
import '../profile/controller/profile_controller.dart';

class LoginScreen extends GetWidget<LoginController> {
  final LoginController loginController = Get.find();
  final OTPController otpController = OTPController();
  final AuthService1 authService = Get.put(AuthService1());

  LoginScreen({Key? key}) : super(key: key);

  // Validate the phone number
  bool validatePhoneNumber(String phoneNumber) {
    return phoneNumber.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenheight * 0.1,
                left: screenwidth * 0.06,
              ),
              child: Stack(
                children: [
                  Obx(
                    () => controller.animationPlayed.value
                        ? Text(
                            'Mobile',
                            style:
                                AppTextStyles.getTextStyle(screenheight * 0.08),
                            textAlign: TextAlign.left,
                          )
                        : TypewriterAnimatedTextKit(
                            text: const ['Mobile\nNumber'],
                            textStyle:
                                AppTextStyles.getTextStyle(screenheight * 0.08),
                            textAlign: TextAlign.left,
                            totalRepeatCount: 1,
                            repeatForever: false,
                            speed: const Duration(milliseconds: 200),
                            pause: const Duration(milliseconds: 1000),
                          ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: screenheight * 0.26,
                          left: screenwidth * 0.0002,
                          right: screenwidth * 0.0002),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.showSnackbar(context);
                            },
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage('asset/img/india_flag.png'),
                                  width: screenwidth * 0.09,
                                ).addPaddingRight(padding: screenwidth * 0.02),
                                Text('India +91',
                                        style: AppTextStyles.getTextStyle(
                                            screenheight * 0.02))
                                    .addPaddingVertical(
                                        padding: screenheight * 0.01),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding:
                                  EdgeInsets.only(right: screenheight * 0.02),
                              alignment: AlignmentDirectional.topCenter,
                              child: TextField(
                                style:
                                    TextStyle(fontSize: screenheight * 0.024),
                                onChanged: (value) {
                                  loginController.setPhoneNumber(value);
                                  controller.savePhonenumberToStorage();
                                },
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          screenheight * 0.02),
                                      borderSide: const BorderSide(
                                          color: Colors.green)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenheight * 0.02),
                                  ),
                                  hintText: 'Enter mobile number',
                                  filled: true,
                                  fillColor:
                                      Colors.white, // Set the background color
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Obx(
                    () {
                      if (controller.showLinearProgress.value) {
                        return Container(
                          height: screenheight * 0.004,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.green,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      } else {
                        return Container(); // Placeholder for other UI elements
                      }
                    },
                  ),
                  Text(
                    'Your mobile number will be verified.',
                    style: AppTextStyles.title,
                  ).addPaddingTop(padding: screenheight * 0.04),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GreenButton(
                        text: 'CONTINUE',
                        onPressed: () async {
                          String phoneNumber =
                              loginController.phoneNumber.value;
                          controller.setShowLinearProgress(true);
                          print('phonenumber=$phoneNumber');
                          controller.savePhonenumberToStorage();
                          controller.setShowLinearProgress(false);
                          authService.checkPhoneNumberInFirestoreAndNavigate();

                        }),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.Signuppage);
                      },
                      child: Text('Sign Up'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

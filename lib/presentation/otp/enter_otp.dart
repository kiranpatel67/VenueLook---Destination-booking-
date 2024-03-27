import 'package:FoGraph/core/extensions/padding_extension.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:FoGraph/utils/constant/app_textstyles.dart';
import '../../custom_button.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';
import '../login/controller/login_controller.dart';
import '../otp/controller/otp_controller.dart';
import 'package:FoGraph/core/service/auth_service.dart';

class OTPScreen extends StatelessWidget {
  final LoginController loginController = Get.find();
  final OTPController otpController = Get.put(OTPController());
  final AuthService authService = Get.put(AuthService());

  OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    final defaultPinTheme = PinTheme(
      width: screenwidth * 0.15,
      height: screenheight * 0.09,
      textStyle: TextStyle(color: Colors.white),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.green),
      ),
    );

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
                  Text(
                    'Mobile\nNumber',
                    style: AppTextStyles.getTextStyle(screenheight * 0.08),
                    textAlign: TextAlign.left,
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: screenheight * 0.26,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Handle onTap
                            },
                            child: Row(
                              children: [
                                Image(
                                  image:
                                  AssetImage('asset/img/india_flag.png'),
                                  width: screenwidth * 0.09,
                                ).addPaddingRight(padding: screenwidth * 0.02),
                                Text(
                                  'India +91',
                                  style: AppTextStyles.getTextStyle(
                                      screenheight * 0.02),
                                ).addPaddingVertical(
                                    padding: screenheight * 0.01),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenwidth * 0.04),
                              height: screenheight * 0.08,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      screenheight * 0.02),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.green)),
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                '${loginController.phoneNumber}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenheight * 0.024,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ).addPaddingBottom(
                              padding: screenheight * 0.04).addPaddingRight(
                              padding: screenwidth * 0.05),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 0,
                                  screenwidth * 0.045, screenheight * 0.1),
                              child: Pinput(
                                length: 6,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: defaultPinTheme.copyWith(
                                  decoration: defaultPinTheme.decoration!
                                      .copyWith(
                                    border:
                                    Border.all(color: Colors.white),
                                  ),
                                ),
                                onCompleted: (pin) {
                                  debugPrint(pin);
                                  otpController.setOtp(pin);
                                },
                              )),
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
                  Visibility(
                    visible: !(otpController.isOtpReceived.value),
                    child: Container(
                      height: screenheight * 0.004,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.green,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),

                  Text(
                    'Your mobile number will be verified.',
                    style: AppTextStyles.title,
                  ).addPaddingTop(padding: screenheight * 0.04), // Add some spacing

                  Align(
                    alignment: Alignment.centerLeft,
                    child: GreenButton(
                      text: 'VERIFY OTP',
                      onPressed: () async {
                        // Verify the entered OTP using AuthService
                        bool isOtpValid = await authService.verifyOtp();

                        if (isOtpValid) {
                          // Check if the phone number exists in Firestore
                          bool exists = await authService.checkPhoneNumberInFirestore(loginController.phoneNumber.value);

                          if (exists) {
                            Get.toNamed(AppRoute.homePage);
                          } else {
                            Get.toNamed(AppRoute.userinfoPage);
                            // Phone number doesn't exist, handle accordingly (redirect to appropriate page, show error message, etc.)
                            // For now, let's show a snackbar
                            // Get.snackbar(
                            //   'Error',
                            //   'Phone number does not exist.',
                            //   snackPosition: SnackPosition.BOTTOM,
                            //   backgroundColor: Colors.white,
                            //   snackStyle: SnackStyle.FLOATING,
                            //   borderRadius: 10,
                            //   margin: EdgeInsets.zero,
                            // );
                          }
                        } else {
                          Get.snackbar(
                            'Error',
                            'Incorrect OTP. Please try again.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white,
                            snackStyle: SnackStyle.FLOATING,
                            borderRadius: 10,
                            margin: EdgeInsets.zero,
                          );
                        }
                        otpController.otpReceived();
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
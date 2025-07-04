import 'package:FoGraph/core/extensions/padding_extension.dart';
import 'package:FoGraph/presentation/home/home_screen.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final AuthService1 authService = Get.put(AuthService1());

  OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String verificationId;
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;

    final defaultPinTheme = PinTheme(
      width: screenwidth * 0.15,
      height: screenheight * 0.09,
      textStyle: const TextStyle(color: Colors.white),
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
                                  const AssetImage('asset/img/india_flag.png'),
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
                    child: SizedBox(
                      height: screenheight * 0.004,
                      child: const LinearProgressIndicator(
                        backgroundColor: Colors.green,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),

                  Text(
                    'Your mobile number will be verified.',
                    style: AppTextStyles.title,
                  ).addPaddingTop(padding: screenheight * 0.04),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: GreenButton(
                      text: 'VERIFY OTP',
                      onPressed: () async {
                        authService.handleOtpVerification();
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
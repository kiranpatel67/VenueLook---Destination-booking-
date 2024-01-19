import 'package:FoGraph/core/extensions/padding_extension.dart';
import 'package:FoGraph/presentation/login/controller/login_controller.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../custom_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../utils/constant/app_textstyles.dart';

class LoginScreen extends GetWidget<LoginController> {
  final LoginController loginController = Get.find();

  final FocusNode _focusNode = FocusNode();

  LoginScreen({Key? key}) : super(key: key);

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
                      style: AppTextStyles.getTextStyle(screenheight*0.08),
                      textAlign: TextAlign.left,
                    )
                        : TypewriterAnimatedTextKit(
                      text: const ['Mobile\nNumber'],
                      textStyle: AppTextStyles.getTextStyle(screenheight*0.08),
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
                        right: screenwidth*0.0002
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.showSnackbar(context);
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: screenheight*0.01),
                                  child: Text(
                                    'India +91',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenheight * 0.024,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(right: screenheight*0.02),
                              alignment: AlignmentDirectional.topCenter,
                              child: TextField(
                                onChanged: (value) => loginController.setPhoneNumber(value),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(screenheight*0.02),
                                    borderSide: const BorderSide(
                                      color: Colors.green
                                    )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(screenheight*0.02),
                                  ),
                                  hintText: 'Enter mobile number',
                                  filled: true,
                                  fillColor: Colors.white, // Set the background color
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
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Text(
                    'Your mobile number will be verified.',
                    style: AppTextStyles.title,
                  ),
                  Positioned(
                    top: screenheight * 0.06,
                    child: GreenButton(
                      text: 'CONTINUE',
                      onPressed: () {
                        // print(controller.textEditingController.text);
                        // String phoneNumber = controller.textEditingController.text;
                        Get.toNamed(AppRoute.otpPage);
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

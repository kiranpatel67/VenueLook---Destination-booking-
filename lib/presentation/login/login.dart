import 'package:fographdestinationbooking/core/extensions/padding_extension.dart';
import 'package:fographdestinationbooking/presentation/login/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../custom_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../utils/constant/app_textstyles.dart';




class EnterPhone extends GetWidget<LoginController> {

  EnterPhone({Key? key}) : super(key: key);

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
                      style: AppHeadingStyle.heading,
                      textAlign: TextAlign.left,
                    )
                        : TypewriterAnimatedTextKit(
                      text: const ['Mobile\nNumber'],
                      textStyle: AppHeadingStyle.heading,
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
                                keyboardType: TextInputType.phone,
                                controller: controller.textEditingController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(screenheight*0.02),
                                    borderSide: BorderSide(
                                      color: Colors.green
                                    )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(screenheight*0.02)
                                  ),
                                  labelText: 'Enter mobile number',
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
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
                        print(controller.textEditingController.text);
                        Get.toNamed('/otp');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ).addPadding(),
    );
  }
}

import 'package:FoGraph/core/extensions/padding_extension.dart';
import 'package:FoGraph/core/service/auth_service.dart';
import 'package:FoGraph/presentation/login/controller/login_controller.dart';
import 'package:FoGraph/presentation/userinfo/controller/userinfo_controller.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../custom_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../utils/constant/app_textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoScreen extends GetWidget<LoginController> {
  final UserInfoController userInfoController = Get.put(UserInfoController());
  final FocusNode _focusNode = FocusNode();
  final LoginController loginController = Get.put(LoginController());

  final AuthService1 authService = Get.put(AuthService1());

  UserInfoScreen({Key? key}) : super(key: key);

  // Validate the fields
  bool validateFields() {
    return userInfoController.name.isNotEmpty &&
        userInfoController.email.isNotEmpty;
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
                      text: const ['Your\nName'],
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
                          Container(
                            padding:
                            EdgeInsets.only(right: screenwidth * 0.04),
                            alignment: AlignmentDirectional.topCenter,
                            child: TextField(
                              style: TextStyle(fontSize: screenheight * 0.024),
                              onChanged: (value) =>
                                  userInfoController.setName(value),
                              keyboardType: TextInputType.text,
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
                                hintText: 'Enter your name',
                                filled: true,
                                fillColor:
                                Colors.white, // Set the background color
                              ),
                            ),
                          ).addPaddingVertical(padding: screenheight * 0.004),
                          Container(
                            padding:
                            EdgeInsets.only(right: screenwidth * 0.04),
                            alignment: AlignmentDirectional.topCenter,
                            child: TextField(
                              style: TextStyle(fontSize: screenheight * 0.024),
                              onChanged: (value) =>
                                  userInfoController.setEmail(value),
                              keyboardType: TextInputType.emailAddress,
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
                                hintText: 'Enter your email',
                                filled: true,
                                fillColor:
                                Colors.white, // Set the background color
                              ),
                            ),
                          ).addPaddingVertical(padding: screenheight * 0.004),
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
                    'Please enter your name and email.',
                    style: AppTextStyles.title,
                  ),
                  Positioned(
                    top: screenheight * 0.06,
                    child: GreenButton(
                      text: 'CONTINUE',
                      onPressed: () async {
                        String name = userInfoController.name.value;
                        String email = userInfoController.email.value;
                        if (validateFields()) {
                          await addUserToFirestore(name, email);
                          // Get.toNamed(AppRoute.homePage);
                          Get.toNamed(AppRoute.profilePage);
                        } else {
                          // Show a snackbar for empty fields
                          Get.snackbar(
                            'Empty Fields',
                            'Please enter your name and email.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white,
                            snackStyle: SnackStyle.FLOATING,
                            borderRadius: 10,
                            margin: EdgeInsets.zero,
                          );
                        }
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

  Future<void> addUserToFirestore(String name, String email) async {
    // Reference to the "users" collection in Firestore
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String phoneNumber = loginController.phoneNumber.value;
    // Add a new document with the phone number as the document name
    await users.doc(phoneNumber).set({
      'phone' : phoneNumber,
      'mail': email,
      'name': name,
      // You can add additional fields here as needed
    });
  }
}

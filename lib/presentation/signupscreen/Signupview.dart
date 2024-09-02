import 'package:FoGraph/presentation/login/controller/login_controller.dart';
import 'package:FoGraph/presentation/signupscreen/SignupController.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../custom_button.dart';
import 'Signupbinding.dart';

class SignupView extends GetView<Signupcontroller> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LoginController loginController = Get.find();
  SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    'Your\nname',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  alignment: AlignmentDirectional.topCenter,
                  child: TextField(
                    controller: controller.Namecontroller,
                    style: TextStyle(fontSize: screenheight * 0.024),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenheight * 0.02),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenheight * 0.02),
                      ),
                      hintText: 'Enter your Name',
                      filled: true,
                      fillColor: Colors.white, // Set the background color
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  alignment: AlignmentDirectional.topCenter,
                  child: TextField(
                    controller: controller.emailcontroller,
                    style: TextStyle(fontSize: screenheight * 0.024),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenheight * 0.02),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenheight * 0.02),
                      ),
                      hintText: 'Enter your Email',
                      filled: true,
                      fillColor: Colors.white, // Set the background color
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    'Please Enter Your Name And Email',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: GreenButton(
                    text: 'CONTINUE',
                    onPressed: () async {
                      String email = controller.emailcontroller.text;
                      String password = 'your-password'; // You can set a default password or add a password field
                      String name = controller.Namecontroller.text;
                      String phonenumber = loginController.phoneNumber.value;

                      try {
                        // Sign up the user
                        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        User? user = userCredential.user;

                        if (user != null) {
                          String uid = user.uid;
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .set({
                            'name': name,
                            'email': email,
                            'phone' : phonenumber,
                            'userID': uid,
                          });
                          Get.toNamed(AppRoute.homePage);
                        }
                      } catch (e) {
                        print('Error: $e');
                        Get.snackbar(
                          'Signup Error',
                          e.toString(),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

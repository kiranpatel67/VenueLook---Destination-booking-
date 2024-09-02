import 'dart:ffi';

import 'package:FoGraph/core/extensions/padding_extension.dart';
import 'package:FoGraph/custom_button.dart';
import 'package:FoGraph/presentation/login/controller/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FoGraph/presentation/userinfo/controller/userinfo_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../Data_model/UserData_model.dart';
import '../../authservice.dart';
import '../../core/service/auth_service.dart';
import '../profile/controller/profile_controller.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.find();
  UserInfoController userInfoController = Get.put(UserInfoController());
  LoginController loginController = Get.put(LoginController());
  final AuthService1 authService = Get.put(AuthService1());
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            SizedBox(height: 16.0),
            Profile(),
            Editprofilebutton(context),
            _buildSignOutButton(context),
            // _buildActionButtons(context),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }


  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/img/profile_bg.jpeg'),
              // Replace with your image
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.26 - 30.0,
          left: MediaQuery
              .of(context)
              .size
              .width * 0.15,
          child: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3.0,
              ),
            ),
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('asset/img/fograph_logo.png'),
            ),
          ),
        ),
      ],
    );
  }

  Widget Profile() {
      final storage = GetStorage();
     var userName = storage.read('name') ?? '';
     var userPhone= storage.read('email')?? '';
     var userEmail= storage.read('phone')?? '';
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.person, userName, 4.0),
            _buildInfoRow(Icons.phone, userPhone, 4.0),
            _buildInfoRow(Icons.email, userEmail, 4.0),
          ],
        ),
      );
  }

  Widget _buildInfoRow(IconData icon, String text, double spacing) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1)
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.fromLTRB(16, 6, 16, 6), // Add padding to the container
      child: Row(
        children: [
          Icon(icon, size: 24),
          SizedBox(width: spacing),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: controller.selectedIndex.value,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        controller.changeTabIndex(index);
        _navigateToPage(index);
      },
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed(AppRoute.homePage);
        break;
      case 1:
        Get.offAllNamed(AppRoute.bookingsPage);
        break;
      case 2:
        Get.offAllNamed(AppRoute.profilePage);
        break;
    }
  }

  Widget Editprofilebutton(BuildContext context) {
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.30),
      child: GestureDetector(
        onTap: () {
          _showSlidingPanel(context);
        },
        child: Container(
          height: screenheight * 0.045,
          width: screenheight * 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white, // S
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/editiconpng.png',
                width: 20,
                height: 20,
              ).addPaddingRight(padding: 5),

              Text(
                'EDIT PROFILE',
                style: TextStyle(
                    color: Colors.black, fontSize: screenheight * 0.02,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ).addPaddingTop(padding: screenheight * 0.03);
  }

  void _showSlidingPanel(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        // Get the current view insets (keyboard height)
        final bottomInset = MediaQuery
            .of(context)
            .viewInsets
            .bottom;

        return AnimatedPadding(
          padding: EdgeInsets.only(bottom: bottomInset),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Update Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text('Name'),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(13, 0, 8, 0),
                            child: TextField(
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                hintText: '${controller.userName}',
                                hintStyle: TextStyle(
                                    fontSize: 15, color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              controller: controller.nameController,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text('Email'),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(13, 0, 8, 0),
                            child: TextField(
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                hintText: '${controller.userEmail}',
                                hintStyle: TextStyle(
                                    fontSize: 15, color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              controller: controller.emailController,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          controller.handleUpdate();
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            'UPDATE',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _buildSignOutButton(BuildContext context) {
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.33),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoute.loginPage);
        },
        child: Container(
          height: screenheight * 0.045,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.green, // Set the button color to green
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                  Icons.logout, color: Colors.white, size: screenheight * 0.025)
                  .addPaddingRight(padding: screenwidth * 0.02),
              Text(
                'SIGN OUT',
                style: TextStyle(
                    color: Colors.white, fontSize: screenheight * 0.02),
              ),
            ],
          ),
        ),
      ),
    ).addPaddingTop(padding: screenheight * 0.03);
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Get.toNamed(AppRoute.landingPage);
  }
}

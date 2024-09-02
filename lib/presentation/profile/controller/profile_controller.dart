import 'package:FoGraph/core/extensions/padding_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Data_model/Profile_data_model.dart';
import '../../login/controller/login_controller.dart';
import '../../userinfo/controller/userinfo_controller.dart';

class ProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  var userProfile = UserProfile(name: '', email: '', phone: '').obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserInfoController userInfoController = Get.put(UserInfoController());
  LoginController loginController = Get.put(LoginController());
  final Rx<String> _userName = ''.obs;
  final Rx<String> _userEmail = ''.obs;
  final Rx<String> _userPhone = ''.obs;
  String get userName => _userName.value;
  String get userEmail => _userEmail.value;
  String get userPhone => _userPhone.value;

  var selectedIndex = 2.obs;
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> createUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateProfile(displayName: userInfoController.name.value);
        print('User Name: ${user.displayName}');
        print('User Email: ${user.email}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkUserAuthentication();
    profileData();
  }

  Future<void> profileData() async {
    String phoneNumber = loginController.phoneNumber.value;
    final storage = GetStorage();
    print('phone= $phoneNumber');
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDoc = querySnapshot.docs.first;
        _userName.value = userDoc['name'];
        print('name=${userDoc['name']}');
        _userPhone.value = phoneNumber;
        _userEmail.value = userDoc['email'];
        print('name=${userDoc['email']}');
        storage.write('name', _userName.value);
        storage.write('email', _userPhone.value);
        storage.write('phone', _userEmail.value);

      } else {
         fetchProfileData();
        _userName.value = userProfile.value.name;
         _userPhone.value = userProfile.value.phone;
        _userEmail.value = userProfile.value.email;
         storage.write('name', _userName.value);
         storage.write('email', _userPhone.value);
         storage.write('phone', _userEmail.value);
      }
    } catch (e) {
      print('Error fetching data from Firestore: $e');
    }
  }

  Future<void> checkUserAuthentication() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user?.uid == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        fetchProfileData();
      }
    });
  }

  void fetchProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        print('Document=${doc.data()}');
        if (doc.exists) {
          userProfile.value = UserProfile.fromFirestore(doc);
          print('User Profile fetched: ${userProfile.value}');
        } else {
          print('No user data found');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  void updateUserProfile(String name, String email) {
    _userName.value= name;
    _userEmail.value = email;
  }


  Future<void> updateUserProfileInFirebase(String name, String email) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? userId = user?.uid;
      print('userid=$userId');
      if (userId != null) {
        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'name': name,
          'email': email,
        });
        print("User profile updated in Firebase");
      }
    } catch (e) {
      print("Error updating user profile: $e");
    }
  }

  void handleUpdate() async {
    String name = nameController.text;
    String email = emailController.text;
    print("Updating profile with Name: $name, Email: $email");
    updateUserProfile(name, email);
    await updateUserProfileInFirebase(name, email);
  }
}


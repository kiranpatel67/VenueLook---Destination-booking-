
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Data_model/UserData_model.dart';

class Signupcontroller extends GetxController {
   TextEditingController emailcontroller= TextEditingController();
   TextEditingController Namecontroller= TextEditingController();

   // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   // FirebaseAuth auth = FirebaseAuth.instance;
   // void createUser() async {
   //    final User? user = auth.currentUser;
   //    if (user != null) {
   //       final String uid = user.uid;
   //       CollectionReference users = _firestore.collection('users');
   //       users.doc(uid).set({
   //          'uid': uid,
   //          'name': Namecontroller.text,
   //          'email': emailcontroller.text,
   //       }).then((value) {
   //          print("User document created: $uid");
   //       }).catchError((error) {
   //          print("Failed to create user document: $error");
   //       });
   //    } else {
   //       print("User is not logged in");
   //    }
   // }
}

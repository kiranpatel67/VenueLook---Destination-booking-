import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UserInfoController extends GetxController {
  RxString name = ''.obs;
  RxString email = ''.obs;
  final RxBool animationPlayed = false.obs;

  void setName (String userName){
    name.value = userName;
  }

  void setEmail (String userMail){
    email.value = userMail;
  }
}
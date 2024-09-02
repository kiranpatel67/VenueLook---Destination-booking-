import 'package:FoGraph/presentation/home/binding/homescreen_binding.dart';
import 'package:FoGraph/presentation/home/home_screen.dart';
import 'package:FoGraph/presentation/login/binding/login_binding.dart';
import 'package:FoGraph/presentation/login/controller/login_controller.dart';
import 'package:FoGraph/presentation/login/login.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/service/auth_service.dart';
import 'presentation/otp/controller/otp_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCBdqfzHD3m6KUF1AexBCNopZ-LMVcvXL0",
      appId: '856661515593:android:58d6ad91f13a5b3cd0551b',
      messagingSenderId: '856661515593',
      storageBucket: "fograph-apps.appspot.com",
      projectId: "fograph-apps",
    ),
  );

  // Initialize GetStorage
  await GetStorage.init();

  // Register LoginController using Get.lazyPut
  Get.lazyPut<LoginController>(() => LoginController());

  Get.lazyPut<OTPController>(() => OTPController());
  Get.put(AuthService1());
  runApp(MyApp());

  // Listen to auth state changes
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      home: firebaseAuth.currentUser != null ? HomeScreen() : LoginScreen(),
      initialBinding: firebaseAuth.currentUser != null
          ? HomeScreenBinding()
          : LoginBinding(),
      getPages: AppRoute.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

//otp - service (authentication)

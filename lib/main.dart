import 'package:FoGraph/presentation/home/binding/homescreen_binding.dart';
import 'package:FoGraph/presentation/home/home_screen.dart';
import 'package:FoGraph/presentation/landing/binding/landing_binding.dart';
import 'package:FoGraph/presentation/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'presentation/landing/landing_page.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'presentation/otp/controller/otp_controller.dart';

void main() async{
  //firebase initialize (default...)
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCBdqfzHD3m6KUF1AexBCNopZ-LMVcvXL0",
          appId: '856661515593',
          messagingSenderId: '856661515593',
          storageBucket: "fograph-apps.appspot.com",
          projectId: "fograph-apps")
  );

  Get.lazyPut(() => OTPController());
  runApp(MyApp());}


class MyApp extends StatelessWidget {
  MyApp({super.key});
  FirebaseAuth firebaseAuth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      home: firebaseAuth.currentUser != null? HomeScreen(): LandingPage(),
      initialBinding: firebaseAuth.currentUser != null? HomeScreenBinding(): LandingBinding(),
      // home: HomeScreen(),
      // initialBinding: HomeScreenBinding(),
      getPages: AppRoute.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

//otp - service (authentication)

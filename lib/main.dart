import 'package:flutter/material.dart';
import 'package:fographdestinationbooking/presentation/login/login.dart';
import 'package:fographdestinationbooking/enter_otp.dart';
import 'landing_page.dart';
import 'package:get/get.dart';

void main() {runApp(MyApp());}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      home: IntroPage(),
      getPages: [
        GetPage(name: "/", page:() => IntroPage()),
        GetPage(name: "/mobile", page: () => EnterPhone()),
        GetPage(name: "/otp", page: () => EnterOTP())
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}




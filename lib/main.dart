import 'package:FoGraph/presentation/landing/binding/landing_binding.dart';
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
      projectId: "fograph-apps")
  );

  Get.lazyPut(() => OTPController());
  runApp(MyApp());}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      home: LandingPage(),
      initialBinding: LandingBinding(),
      getPages: AppRoute.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

//otp - service (authentication)


import 'package:flutter/material.dart';
import 'package:FoGraph/routes/app_route.dart';
import 'presentation/landing/landing_page.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  //firebase initialize (default...)
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      home: LandingPage(),
      getPages: AppRoute.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}




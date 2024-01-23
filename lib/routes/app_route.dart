import 'package:FoGraph/presentation/home/home_screen.dart';
import 'package:FoGraph/presentation/login/binding/login_binding.dart';
import 'package:FoGraph/presentation/login/login.dart';
import 'package:FoGraph/presentation/otp/binding/otp_binding.dart';
import 'package:FoGraph/presentation/otp/enter_otp.dart';
import 'package:FoGraph/presentation/userinfo/user_info.dart';
import 'package:get/get.dart';

class AppRoute{
  static const String loginPage = "/login";
  static const String landingPage = "/landing";
  static const String otpPage = "/otp";
  static const String userinfoPage = "/userinfo";
  static const String homePage = "/homepage";
  static List<GetPage> routes = [
    GetPage(name: loginPage, page: ()=> LoginScreen(), bindings: [LoginBinding()]),
    GetPage(name: otpPage, page: ()=> OTPScreen(), bindings: [OTPBinding()]),
    GetPage(name: userinfoPage, page: ()=>UserInfoScreen()),
    GetPage(name: homePage, page: ()=>HomeScreen())
  ];
}
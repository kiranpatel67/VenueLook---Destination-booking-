import 'package:FoGraph/presentation/login/binding/login_binding.dart';
import 'package:FoGraph/presentation/login/login.dart';
import 'package:FoGraph/presentation/otp/binding/otp_binding.dart';
import 'package:FoGraph/presentation/otp/enter_otp.dart';
import 'package:get/get.dart';

class AppRoute{
  static const String loginPage = "/login";
  static const String landingPage = "/landing";
  static const String otpPage = "/otp";
  static List<GetPage> routes = [
    GetPage(name: loginPage, page: ()=> LoginScreen(), bindings: [LoginBinding()]),
    GetPage(name: otpPage, page: ()=> OTPScreen(), bindings: [OTPBinding()]),
  ];
}
import 'package:FoGraph/presentation/bookings/binding/bookings_controller.dart';
import 'package:FoGraph/presentation/bookings/bookings_page.dart';
import 'package:FoGraph/presentation/home/home_screen.dart';
import 'package:FoGraph/presentation/login/binding/login_binding.dart';
import 'package:FoGraph/presentation/login/login.dart';
import 'package:FoGraph/presentation/otp/binding/otp_binding.dart';
import 'package:FoGraph/presentation/otp/enter_otp.dart';
import 'package:FoGraph/presentation/profile/binding/profile_binding.dart';
import 'package:FoGraph/presentation/profile/profile_page.dart';
import 'package:FoGraph/presentation/request%20booking/binding/requestbooking_binding.dart';
import 'package:FoGraph/presentation/request%20booking/request_booking.dart';
import 'package:FoGraph/presentation/userinfo/binding/userinfo_binding.dart';
import 'package:FoGraph/presentation/userinfo/user_info.dart';
import 'package:get/get.dart';

import '../presentation/request booking/getview.dart';

class AppRoute{
  static const String loginPage = "/login";
  static const String landingPage = "/landing";
  static const String otpPage = "/otp";
  static const String userinfoPage = "/userinfo";
  static const String homePage = "/homepage";
  static const String profilePage = "/profilepage";
  static const String bookingsPage = "/bookingspage";
  static const String navigation = "/navigation";
  static const String requestbooking = "/requestbooking";
  static List<GetPage> routes = [
    GetPage(name: loginPage, page: ()=> LoginScreen(), bindings: [LoginBinding()]),
    GetPage(name: otpPage, page: ()=> OTPScreen(), bindings: [OTPBinding()]),
    GetPage(name: userinfoPage, page: ()=>UserInfoScreen(), bindings: [UserInfoBinding()]),
    GetPage(name: homePage, page: ()=>HomeScreen()),
    GetPage(name: profilePage, page: ()=>ProfilePage(), bindings: [ProfileBinding()]),
    GetPage(name: bookingsPage, page: ()=>BookingsPage(), bindings: [BookingsBinding()]),
    GetPage(name: requestbooking, page: ()=> RequestBookingsPage(), bindings: [RequestBookingsBinding()])
  ];
}
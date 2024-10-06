import 'package:flutter/material.dart';
import 'package:get_your_fashion/view/bottom_nev_bar.dart';
import 'package:get_your_fashion/utils/routes/routes_name.dart';
import 'package:get_your_fashion/view/auth/otp_screen.dart';
import 'package:get_your_fashion/view/splash_screen.dart';
import '../../view/auth/login_screen.dart';
import '../../view/home/category_screen.dart';



final Map<String, WidgetBuilder> routes = {
  RoutesName.splash: (context) => const SplashScreen(),
  RoutesName.loginScreen: (context) => const LoginScreen(),
  RoutesName.otpScreen: (context) => const OtpScreen(),
  RoutesName.bottomScreen: (context) => const BottomNevBar(),
  RoutesName.categoryScreen: (context) => const CategoryScreen(),
};
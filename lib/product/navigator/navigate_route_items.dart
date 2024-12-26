import 'package:diet_app_mobile/views/basic/onboarding/onboarding_three_view.dart';
import 'package:diet_app_mobile/views/basic/login/login_view.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_one_view.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_two_view.dart';
import 'package:diet_app_mobile/views/basic/register/register_view.dart';
import 'package:diet_app_mobile/views/basic/splash/splash_view.dart';
import 'package:diet_app_mobile/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class NavigatorRoutes {
  static const String init = "/";
  final List<GetPage<dynamic>>? routes = [
    GetPage(
        name: NavigateRoutesItems.init.withSlash,
        page: () => const SplashView(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(name: NavigateRoutesItems.login.withSlash,page: () => const LoginView(),transition: Transition.cupertino,transitionDuration: const Duration(milliseconds: 500),curve: Curves.easeInOut),
    GetPage(name: NavigateRoutesItems.register.withSlash,page: () => const RegisterView(),transition: Transition.cupertino,transitionDuration: const Duration(milliseconds: 500),curve: Curves.easeInOut),
    GetPage(name: NavigateRoutesItems.onboardingOne.withSlash,page: () => OnboardingOneView(),transition: Transition.cupertino,transitionDuration: const Duration(milliseconds: 500),curve: Curves.easeInOut),
    GetPage(name: NavigateRoutesItems.onboardingTwo.withSlash,page: () => OnboardingTwoView(),transition: Transition.cupertino,transitionDuration: const Duration(milliseconds: 500),curve: Curves.easeInOut),
    GetPage(name: NavigateRoutesItems.onboardingThree.withSlash,page: () => OnboardingThreeView(),transition: Transition.cupertino,transitionDuration: const Duration(milliseconds: 500),curve: Curves.easeInOut),
    GetPage(name: NavigatorRoutes.init,page: () =>const HomeView(),transition: Transition.cupertino,transitionDuration: const Duration(milliseconds: 500),curve: Curves.easeInOut),

    // GetPage(name: NavigateRoutesItems.unknown.withSlash, page: () => const UnknownScreen(),transition: Transition.cupertino,transitionDuration: const Duration(milliseconds: 500),curve: Curves.easeInOut),
    // StorageServices().loadData(StorageItems.isUserRegistered) == true ?  MainScreen() :
    //  const SplashScreen(),
  ];
}

enum NavigateRoutesItems {
  init,
  splash,
  unknown,
  login,
  home,
  register,
  onboardingOne,
  onboardingTwo,
  onboardingThree,
}

extension NavigateRoutesItemsExtension on NavigateRoutesItems {
  String get withSlash => "/$name";
}

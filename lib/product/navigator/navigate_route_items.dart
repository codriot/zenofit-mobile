import 'package:diet_app_mobile/views/basic/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';



class NavigatorRoutes {
  static const String init = "/";
  final List<GetPage<dynamic>>? routes = [
    GetPage(name: NavigatorRoutes.init, page: () =>
   const LoginView(),
    // StorageServices().loadData(StorageItems.isUserRegistered) == true ?  MainScreen() :
    //  const SplashScreen(),
     transition: Transition.cupertino,transitionDuration: const Duration(milliseconds: 500),curve: Curves.easeInOut),
    // GetPage(name: NavigateRoutesItems.unknown.withSlash, page: () => const UnknownScreen(),transition: Transition.cupertino,transitionDuration: const Duration(milliseconds: 500),curve: Curves.easeInOut),

  ];
}

enum NavigateRoutesItems {
  init,
  splash,
  unknown,
  introduction,
  login,
  signIn,
  verificationCode,
  welcome,
  stepOne,
  stepTwo,
  stepThree,
  stepFour,
  success,
  home,
  main,
  lesson,
  lessonLearn,
  settings,
  goals,
  notes,
  planner,
  community,
  duello
}

extension NavigateRoutesItemsExtension on NavigateRoutesItems{
  String get withSlash => "/$name";
}
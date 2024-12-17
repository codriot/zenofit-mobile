import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorController extends GetxController{
  NavigatorController._();
  static NavigatorController instance = NavigatorController._();
  final GlobalKey<NavigatorState> _navigatorGlobalKey = GlobalKey();

  GlobalKey<NavigatorState> get navigatorGlobalKey => _navigatorGlobalKey;

  void pushToPage(NavigateRoutesItems route, {Object? arguments}) {
    Get.toNamed(route.withSlash, arguments: arguments);
  }

  void pop() {
    Get.back();
  }

  void pushReplacement(NavigateRoutesItems route, {Object? arguments}) {
    Get.offNamed(route.withSlash, arguments: arguments);
  }

  void pushAndRemoveUntil(NavigateRoutesItems route, {Object? arguments}) {
    Get.offAllNamed(route.withSlash, arguments: arguments);
  }
}
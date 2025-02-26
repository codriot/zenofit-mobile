import 'package:diet_app_mobile/bindings/views/auth/login_binding.dart';
import 'package:diet_app_mobile/bindings/views/basic/onboarding/onboarding_one_binding.dart';
import 'package:diet_app_mobile/bindings/views/basic/onboarding/onboarding_two_binding.dart';
import 'package:diet_app_mobile/bindings/views/basic/onboarding/onboarding_three_binding.dart';
import 'package:diet_app_mobile/bindings/views/basic/onboarding/onboarding_four_binding.dart';
import 'package:diet_app_mobile/bindings/views/basic/onboarding/onboarding_five_binding.dart';
import 'package:diet_app_mobile/bindings/views/basic/onboarding/onboarding_six_binding.dart';
import 'package:diet_app_mobile/bindings/views/main/main_binding.dart';
import 'package:diet_app_mobile/bindings/views/meal/meal_add_fast_item_binding.dart';
import 'package:diet_app_mobile/bindings/views/meal/meal_add_filter_search_binding.dart';
import 'package:diet_app_mobile/bindings/views/meal/meal_add_filter_search_detail_binding.dart';
import 'package:diet_app_mobile/bindings/views/water/add_water_binding.dart';
import 'package:diet_app_mobile/controller/home/meal/meal_add_detail_binding.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_five_view.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_four_view.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_six_view.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_three_view.dart';
import 'package:diet_app_mobile/views/basic/login/login_view.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_one_view.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_two_view.dart';
import 'package:diet_app_mobile/views/basic/register/register_view.dart';
import 'package:diet_app_mobile/views/basic/splash/splash_view.dart';
import 'package:diet_app_mobile/views/home/add_water_view.dart';
import 'package:diet_app_mobile/views/home/home_view.dart';
import 'package:diet_app_mobile/views/home/meal_add_detail_view.dart';
import 'package:diet_app_mobile/views/home/meal_add_fast_item_view.dart';
import 'package:diet_app_mobile/views/home/meal_add_filter_search_detail_view.dart';
import 'package:diet_app_mobile/views/home/meal_add_filter_search_view.dart';
import 'package:diet_app_mobile/views/home/meal_add_view.dart';
import 'package:diet_app_mobile/views/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:diet_app_mobile/controller/home/meal/meal_add_binding.dart';

class NavigatorRoutes {
  static const String init = "/";
  final List<GetPage<dynamic>>? routes = [
    GetPage(
        name: NavigatorRoutes.init,
        page: () => const SplashView(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.login.withSlash,
        page: () => const LoginView(),
        transition: Transition.cupertino,
        binding: LoginBinding(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.register.withSlash,
        page: () => const RegisterView(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.onboardingOne.withSlash,
        page: () => OnboardingOneView(),
        transition: Transition.cupertino,
        binding: OnboardingOneBinding(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.onboardingTwo.withSlash,
        page: () => OnboardingTwoView(),
        transition: Transition.cupertino,
        binding: OnboardingTwoBinding(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.onboardingThree.withSlash,
        page: () => OnboardingThreeView(),
        transition: Transition.cupertino,
        binding: OnboardingThreeBinding(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),

    GetPage(
        name: NavigateRoutesItems.home.withSlash,
        page: () => const HomeView(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),

    GetPage(
        name: NavigateRoutesItems.onboardingFour.withSlash,
        page: () => OnboardingFourView(),
        transition: Transition.cupertino,
        binding: OnboardingFourBinding(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.onboardingFive.withSlash,
        page: () => OnboardingFiveView(),
        transition: Transition.cupertino,
        binding: OnboardingFiveBinding(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.onboardingSix.withSlash,
        page: () => OnboardingSixView(),
        transition: Transition.cupertino,
        binding: OnboardingSixBinding(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.addMeal.withSlash,
        page: () => const MealAddView(),
        binding: MealAddBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.addMealDetail.withSlash,
        page: () => const MealAddDetailView(),
        binding: MealAddDetailBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.addMealFilterSearch.withSlash,
        page: () => const MealAddFilterSearchView(),
        binding: MealAddFilterSearchBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.addMealFastItem.withSlash,
        page: () => const MealAddFastItemView(),
        binding: MealAddFastItemBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.addMealFilterSearchDetail.withSlash,
        page: () => const MealAddFilterSearchDetailView(),
        binding: MealAddFilterSearchDetailBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.addWater.withSlash,
        page: () => const AddWaterView(),
        binding: AddWaterBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.main.withSlash,
        page: () => const MainView(),
        binding: MainBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),

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
  onboardingFour,
  onboardingFive,
  onboardingSix,
  addMeal,
  addMealDetail,
  addMealFilterSearch,
  addMealFastItem,
  addMealFilterSearchDetail,
  addWater,
  main,
}

extension NavigateRoutesItemsExtension on NavigateRoutesItems {
  String get withSlash => "/$name";
}

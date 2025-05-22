import 'package:diet_app_mobile/bindings/views/auth/login_binding.dart';
import 'package:diet_app_mobile/bindings/views/auth/register_binding.dart';
import 'package:diet_app_mobile/bindings/views/basic/onboarding/onboarding_one_binding.dart';
import 'package:diet_app_mobile/bindings/views/basic/onboarding/onboarding_two_binding.dart';
import 'package:diet_app_mobile/bindings/views/basic/onboarding/onboarding_three_binding.dart';
import 'package:diet_app_mobile/bindings/views/basic/onboarding/onboarding_four_binding.dart';
import 'package:diet_app_mobile/bindings/views/basic/onboarding/onboarding_five_binding.dart';
import 'package:diet_app_mobile/bindings/views/basic/onboarding/onboarding_six_binding.dart';
import 'package:diet_app_mobile/bindings/views/dietition/dietition_view_binding.dart';
import 'package:diet_app_mobile/bindings/views/discover/discover_view_binding.dart';
import 'package:diet_app_mobile/bindings/views/home/home_view_binding.dart';
import 'package:diet_app_mobile/bindings/views/main/chat_detail_binding.dart';
import 'package:diet_app_mobile/bindings/views/main/chat_view_binding.dart';
import 'package:diet_app_mobile/bindings/views/main/main_binding.dart';
import 'package:diet_app_mobile/bindings/views/meal/meal_add_fast_item_binding.dart';
import 'package:diet_app_mobile/bindings/views/meal/meal_add_filter_search_binding.dart';
import 'package:diet_app_mobile/bindings/views/meal/meal_add_filter_search_detail_binding.dart';
import 'package:diet_app_mobile/bindings/views/profile/profile_view_binding.dart';
import 'package:diet_app_mobile/bindings/views/water/add_water_binding.dart';
import 'package:diet_app_mobile/controller/home/meal/meal_add_detail_binding.dart';
import 'package:diet_app_mobile/views/dietitian/dietitian_complain_succes_view.dart';
import 'package:diet_app_mobile/views/dietitian/dietitian_complain_view.dart';
import 'package:diet_app_mobile/views/dietitian/dietitian_detail_view.dart';
import 'package:diet_app_mobile/views/dietitian/dietitian_view.dart';
import 'package:diet_app_mobile/views/dietitian/dietitian_vote_view.dart';
import 'package:diet_app_mobile/views/discover/discover_detail_view.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_five_view.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_four_view.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_six_view.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_three_view.dart';
import 'package:diet_app_mobile/views/basic/login/login_view.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_one_view.dart';
import 'package:diet_app_mobile/views/basic/onboarding/onboarding_two_view.dart';
import 'package:diet_app_mobile/views/basic/register/register_view.dart';
import 'package:diet_app_mobile/views/basic/splash/splash_view.dart';
import 'package:diet_app_mobile/views/discover/discover_view.dart';
import 'package:diet_app_mobile/views/home/aboned_view.dart';
import 'package:diet_app_mobile/views/home/add_water_view.dart';
import 'package:diet_app_mobile/views/home/chat_detail_view.dart';
import 'package:diet_app_mobile/views/home/chat_view.dart';
import 'package:diet_app_mobile/views/home/home_view.dart';
import 'package:diet_app_mobile/views/home/meal_add_detail_view.dart';
import 'package:diet_app_mobile/views/home/meal_add_fast_item_view.dart';
import 'package:diet_app_mobile/views/home/meal_add_filter_search_detail_view.dart';
import 'package:diet_app_mobile/views/home/meal_add_filter_search_view.dart';
import 'package:diet_app_mobile/views/home/meal_add_view.dart';
import 'package:diet_app_mobile/views/main/main_view.dart';
import 'package:diet_app_mobile/views/profile/profile_view.dart';
import 'package:diet_app_mobile/views/profile/settings/blocked/blocked_view.dart';
import 'package:diet_app_mobile/views/profile/settings/saved/saved_screen.dart';
import 'package:diet_app_mobile/views/profile/settings/settings_view.dart';
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
        binding: RegisterBinding(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.onboardingOne.withSlash,
        page: () => const OnboardingOneView(),
        transition: Transition.cupertino,
        binding: OnboardingOneBinding(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.onboardingTwo.withSlash,
        page: () => const OnboardingTwoView(),
        transition: Transition.cupertino,
        binding: OnboardingTwoBinding(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.onboardingThree.withSlash,
        page: () => const OnboardingThreeView(),
        transition: Transition.cupertino,
        binding: OnboardingThreeBinding(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),

    GetPage(
        name: NavigateRoutesItems.home.withSlash,
        page: () => const HomeView(),
        transition: Transition.cupertino,
        binding: HomeViewBindings(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),

    GetPage(
        name: NavigateRoutesItems.onboardingFour.withSlash,
        page: () => const OnboardingFourView(),
        transition: Transition.cupertino,
        binding: OnboardingFourBinding(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.onboardingFive.withSlash,
        page: () => const OnboardingFiveView(),
        transition: Transition.cupertino,
        binding: OnboardingFiveBinding(),
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.onboardingSix.withSlash,
        page: () => const OnboardingSixView(),
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
    GetPage(
        name: NavigateRoutesItems.discoverDetail.withSlash,
        page: () => DiscoverDetailView(),
        binding: MainBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.dietitianDetail.withSlash,
        page: () => DietitianDetailView(),
        binding: MainBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.dietitianComplain.withSlash,
        page: () => const DietitianComplainView(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.dietitianComplainSucces.withSlash,
        page: () => const DietitianComplainSuccesView(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.dietitianVote.withSlash,
        page: () => const DietitianVoteView(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.chat.withSlash,
        page: () => const ChatView(),
        binding: ChatViewBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.chatDetail.withSlash,
        page: () => const ChatDetailView(),
        binding: ChatDetailBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.aboned.withSlash,
        page: () => const AbonedView(),
        binding: MainBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.discover.withSlash,
        page: () => const DiscoverView(),
        binding: DiscoverViewBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.dietitian.withSlash,
        page: () => const DietitianView(),
        binding: DietitianViewBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.formerDietitian.withSlash,
        page: () => const DietitianView(isFormer: true),
        binding: DietitianViewBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.profile.withSlash,
        page: () => ProfileView(),
        binding: ProfileViewBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.settings.withSlash,
        page: () => const SettingsView(),
        binding: ProfileViewBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.savedScreen.withSlash,
        page: () => const SavedScreen(),
        binding: ProfileViewBinding(),
        transition: Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut),
    GetPage(
        name: NavigateRoutesItems.blocked.withSlash,
        page: () => const BlockedView(),
        binding: ProfileViewBinding(),
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
  discover,
  discoverDetail,
  dietitian,
  formerDietitian,
  dietitianDetail,
  dietitianComplain,
  dietitianComplainSucces,
  dietitianVote,
  chat,
  chatDetail,
  aboned,
  profile,
  settings,
  savedScreen,
  blocked
}

extension NavigateRoutesItemsExtension on NavigateRoutesItems {
  String get withSlash => "/$name";
}

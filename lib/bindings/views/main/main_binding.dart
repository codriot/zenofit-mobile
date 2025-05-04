import 'package:diet_app_mobile/controller/dietition/dietition_view_controller.dart';
import 'package:diet_app_mobile/controller/profile/profile_view_controller.dart';
import 'package:get/get.dart';
import 'package:diet_app_mobile/controller/home/home_view_controller.dart';
import 'package:diet_app_mobile/controller/main/main_controller.dart';
import 'package:diet_app_mobile/controller/discover/discover_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController(), fenix: true);
    Get.lazyPut<HomeViewController>(() => HomeViewController(), fenix: true);
    Get.lazyPut<DiscoverController>(() => DiscoverController(), fenix: true);
    Get.lazyPut<ProfileViewController>(() => ProfileViewController(), fenix: true);
    Get.lazyPut<DietitionViewController>(() => DietitionViewController(), fenix: true);
  }
}

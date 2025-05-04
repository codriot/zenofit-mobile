
import 'package:diet_app_mobile/controller/profile/profile_view_controller.dart';
import 'package:get/get.dart';

class ProfileViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileViewController>(() => ProfileViewController());
  }
}
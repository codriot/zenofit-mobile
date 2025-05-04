

import 'package:diet_app_mobile/controller/discover/discover_controller.dart';
import 'package:get/get.dart';

class DiscoverViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiscoverController>(() => DiscoverController());
  }
}
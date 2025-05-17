import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core servisler ve global controller'lar burada initialize edilecek
    // Örnek:
    // Get.put(ThemeController(), permanent: true);
    // Get.put(AuthController(), permanent: true);
  }
} 
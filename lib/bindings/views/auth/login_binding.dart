import 'package:get/get.dart';
import '../../../controller/auth/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Auth servisleri ve controller'ı inject ediyoruz
    // Get.lazyPut(() => AuthService());
    Get.lazyPut<LoginController>(() => LoginController());
  }
} 
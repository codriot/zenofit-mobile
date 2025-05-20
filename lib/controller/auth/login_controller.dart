import 'package:diet_app_mobile/API/services/general_serivce.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:flutter/widgets.dart' show TextEditingController;
import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxBool rememberMe = false.obs;

  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void setRememberMe(bool value) {
    rememberMe.value = value;
  }

  void setEmail(String value) {
    email.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  Future<void> login() async {
    if (!_validateInputs()) return;

    try {
      isLoading.value = true;

      // API ile kayıt işlemi
      final authResponse =
          await GeneralService.instance.login(email.value, password.value);

      if (authResponse != null) {
        // Başarılı kayıt sonrası onboarding'e yönlendirme
        NavigatorController.instance
            .pushToPage(NavigateRoutesItems.home);
      }
      
    } catch (e) {
      // Hata yönetimi
      Get.snackbar(
        'Hata',
        'Giriş yapılırken bir hata oluştu',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateInputs() {
    if (email.value.isEmpty || !GetUtils.isEmail(email.value)) {
      Get.snackbar(
        'Hata',
        'Geçerli bir email adresi giriniz',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (password.value.isEmpty || password.value.length < 6) {
      Get.snackbar(
        'Hata',
        'Şifre en az 6 karakter olmalıdır',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    // Controller dispose edilirken yapılacak işlemler
    super.onClose();
  }
} 
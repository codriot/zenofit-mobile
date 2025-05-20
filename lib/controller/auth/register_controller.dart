import 'package:diet_app_mobile/API/services/general_serivce.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../API/services/auth/auth_service.dart';
import '../../product/navigator/navigate_route_items.dart';
import '../../product/navigator/navigator_controller.dart';

class RegisterController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;

  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxString confirmPassword = ''.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();

  final AuthService _authService = AuthService();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void setName(String value) => name.value = value;
  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;
  void setConfirmPassword(String value) => confirmPassword.value = value;
  Future<void> register() async {
    setName(nameController.text.toString());
    setEmail(emailController.text.toString());
    setPassword(passwordController.text.toString());
    setConfirmPassword(passwordAgainController.text.toString());
    if (!_validateInputs()) return;

    try {
      isLoading.value = true;

      // API ile kayıt işlemi
      final authResponse =
          await GeneralService.instance.register(email.value, password.value);

      if (authResponse != null) {
        // Başarılı kayıt sonrası onboarding'e yönlendirme
        
        NavigatorController.instance
            .pushToPage(NavigateRoutesItems.onboardingOne);
      }
    } catch (e) {
      Get.snackbar(
        'Hata',
        'Kayıt işlemi sırasında bir hata oluştu: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateInputs() {
    if (name.value.isEmpty) {
      Get.snackbar(
        'Hata',
        'Lütfen adınızı giriniz',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (email.value.isEmpty || !email.contains("@")) {
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

    if (password.value != confirmPassword.value) {
      Get.snackbar(
        'Hata',
        'Şifreler eşleşmiyor',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      await _authService.signInWithGoogle();
      if (_authService.currentUser != null) {
        NavigatorController.instance
            .pushToPage(NavigateRoutesItems.onboardingOne);
      }
    } catch (e) {
      Get.snackbar(
        'Hata',
        'Google ile giriş yapılırken bir hata oluştu',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithApple() async {
    try {
      isLoading.value = true;
      // Apple sign in işlemleri
    } catch (e) {
      Get.snackbar(
        'Hata',
        'Apple ile giriş yapılırken bir hata oluştu',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

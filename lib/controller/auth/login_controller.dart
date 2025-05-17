import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxBool rememberMe = false.obs;

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
      // TODO: Login işlemleri burada yapılacak
      // Örnek:
      // await authService.login(email.value, password.value);
      // await storageService.saveToken(response.token);
      
      // Başarılı login sonrası ana sayfaya yönlendirme
      // Get.offAllNamed(AppRoutes.HOME);
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
import 'package:get/get.dart';

class CustomTextFieldController extends GetxController {
  var isObscure = true.obs;

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }
}
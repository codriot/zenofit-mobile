import 'package:diet_app_mobile/model/dietition/dietition_model.dart';
import 'package:get/get.dart';

class DietitianDetailController extends GetxController {
  // Accordion durumları
  final RxBool isAboutExpanded = false.obs;
  final RxBool isExperienceExpanded = false.obs;
  final RxBool isEducationExpanded = false.obs;
  final RxBool isCommentsExpanded = false.obs;

  late DietitianModel Dietitian;

  @override
  void onInit() {
    super.onInit();
    Dietitian = Get.arguments;
  }

  void toggleAbout() => isAboutExpanded.value = !isAboutExpanded.value;
  void toggleExperience() =>
      isExperienceExpanded.value = !isExperienceExpanded.value;
  void toggleEducation() =>
      isEducationExpanded.value = !isEducationExpanded.value;
  void toggleComments() => isCommentsExpanded.value = !isCommentsExpanded.value;

  void onSharePressed() {
    // TODO: Paylaşım işlemleri
  }

  void onFavoritePressed() {
    // TODO: Favori işlemleri
  }

  void onCommunicatePressed() {
    // TODO: İletişim işlemleri
  }
}

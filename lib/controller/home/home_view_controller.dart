import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:get/state_manager.dart';

class HomeViewController extends GetxController {

  final userName = "Bilinmeyen Kullanıcı".obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    final user = StorageService.instance.loadUser();
    userName.value = user?.name ?? "Bilinmeyen Kullanıcı";
  }

  var expandedSection = Rxn<ExpansionSection>(); // null olabiliyor

  void toggleSection(ExpansionSection section, bool expanded) {
    expandedSection.value = expanded ? section : null;
  }

  bool isSectionExpanded(ExpansionSection section) =>
      expandedSection.value == section;
}

enum ExpansionSection {
  diet,
  attention,
  shouldEat,
  shouldAvoid,
}
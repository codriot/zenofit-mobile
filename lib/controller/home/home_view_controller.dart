

import 'package:get/state_manager.dart';

class HomeViewController extends GetxController {
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
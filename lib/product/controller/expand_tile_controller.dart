import 'package:get/get.dart';

class ExpandTileController extends GetxController {
  var isExpanded = false.obs;

  void toggleExpanded(bool expanded) {
    isExpanded.value = expanded;
  }
}

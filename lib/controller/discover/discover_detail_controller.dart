import 'package:diet_app_mobile/model/discover/discover_item_model.dart';
import 'package:diet_app_mobile/product/widgets/discover/comments_bottom_sheet.dart';
import 'package:flutter/material.dart' show showModalBottomSheet;
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:get/get.dart';

class DiscoverDetailController extends GetxController {
  late DiscoverItemModel item;
  var isExpandedList =
      <bool>[].obs; // Her öğenin genişleme durumunu tutacak liste
  var itemsLenght = 5.obs; // Observable uzunluk
  var isSoundOn = true.obs; // Observable uzunluk
  @override
  void onInit() {
    super.onInit();
    item = Get.arguments; // Arguments olarak gelen veriyi al
    isExpandedList.value =
        List.filled(itemsLenght.value, false); // Başlangıçta tüm öğeler kapalı
  }

  void toggleExpand(int index) {
    isExpandedList[index] =
        !isExpandedList[index]; // Genişleme durumunu değiştir
    update(); // UI'ı güncelle
  }

  void toggleSound() {
    isSoundOn.value = !isSoundOn.value;
    update(); // UI'ı güncelle
  }

  void showCommentsBottomSheet(BuildContext context, DiscoverItemModel item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Tam ekran olması için gerekli
      builder: (BuildContext context) {
        return CommentsBottomSheet(item: item); // Yeni widget'ı kullan
      },
    );
  }
}

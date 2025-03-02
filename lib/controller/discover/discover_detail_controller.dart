import 'package:diet_app_mobile/model/discover/discover_item_model.dart';
import 'package:get/get.dart';

class DiscoverDetailController extends GetxController {
  late DiscoverItemModel item;
  var isExpandedList =
      <bool>[].obs; // Her öğenin genişleme durumunu tutacak liste
  var items = <DiscoverItemModel>[].obs; // Observable liste
  var itemsLenght = 5.obs; // Observable uzunluk
  @override
  void onInit() {
    super.onInit();
    item = Get.arguments; // Arguments olarak gelen veriyi al
    isExpandedList.value =
        List.filled(itemsLenght.value, false); // Başlangıçta tüm öğeler kapalı
  }

  void toggleExpand(int index) {
    isExpandedList[index] = !isExpandedList[index]; // Genişleme durumunu değiştir
    update(); // UI'ı güncelle
  }
}

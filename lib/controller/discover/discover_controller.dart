import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DiscoverController extends GetxController {
  var items = <String>[].obs; // Observable liste
  var isLoading = false.obs; // Loading durumu
  var hasMoreItems = true.obs; // Daha fazla öğe var mı?

  @override
  void onInit() {
    super.onInit();
    loadInitialItems(); // Başlangıçta öğeleri yükle
  }

  void loadInitialItems() {
    items.addAll(List.generate(10, (index) => 'Öğe ${index + 1}'));
  }

  void loadMoreItems() async {
    if (isLoading.value || !hasMoreItems.value) return; // Zaten yükleniyorsa veya daha fazla öğe yoksa çık

    isLoading.value = true; // Loading durumunu başlat

    // Simüle edilmiş bir yükleme süresi
    await Future.delayed(Duration(seconds: 2));

    // Daha fazla öğe ekle
    if (items.length < 100) { // Toplamda 20 öğe var
      items.addAll(List.generate(10, (index) => 'Öğe ${items.length + index + 1}'));
    } else {
      hasMoreItems.value = false; // Daha fazla öğe yok
    }

    isLoading.value = false; // Loading durumunu bitir
  }

  bool onNotification(ScrollNotification scrollInfo) {
    if (!isLoading.value && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      loadMoreItems(); // Daha fazla öğe yükle
    }
    return true;
  }
}

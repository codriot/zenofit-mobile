import 'dart:math';

import 'package:diet_app_mobile/model/discover/discover_item_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DiscoverController extends GetxController {
  var items = <DiscoverItemModel>[].obs; // Observable liste
  var isLoading = false.obs; // Loading durumu
  var hasMoreItems = true.obs; // Daha fazla öğe var mı?

  @override
  void onInit() {
    super.onInit();
    loadInitialItems(); // Başlangıçta öğeleri yükle
  }

  void loadInitialItems() {
    items.addAll(List.generate(10, (index) {
      String type = index % 2 == 0
          ? 'post'
          : 'video'; // Çift index ise 'post', tek index ise 'video'
      String imageUrl =
          'https://picsum.photos/200?random=${Random().nextInt(1000)}'; // Rastgele resim URL'si
      return DiscoverItemModel(
        type: type,
        imageUrl: imageUrl,
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. $index",
        likeCount: Random().nextInt(1000), // Rastgele beğeni sayısı
        commentCount: Random().nextInt(100), // Rastgele yorum sayısı
      );
    }));
  }

  void loadMoreItems() async {
    if (isLoading.value || !hasMoreItems.value)
      return; // Zaten yükleniyorsa veya daha fazla öğe yoksa çık

    isLoading.value = true; // Loading durumunu başlat

    // Simüle edilmiş bir yükleme süresi
    await Future.delayed(Duration(seconds: 2));

    // Daha fazla öğe ekle
    if (items.length < 100) {
      // Toplamda 100 öğe var
      items.addAll(List.generate(10, (index) {
        String type = (items.length + index) % 2 == 0
            ? 'post'
            : 'video'; // Çift index ise 'post', tek index ise 'video'
        String imageUrl =
            'https://picsum.photos/200?random=${Random().nextInt(1000)}'; // Rastgele resim URL'si
        return DiscoverItemModel(
          type: type,
          imageUrl: imageUrl,
          description: "Açıklama ${items.length + index + 1}",
          likeCount: Random().nextInt(1000), // Rastgele beğeni sayısı
          commentCount: Random().nextInt(100), // Rastgele yorum sayısı
        );
      }));
    } else {
      hasMoreItems.value = false; // Daha fazla öğe yok
    }

    isLoading.value = false; // Loading durumunu bitir
  }

  bool onNotification(ScrollNotification scrollInfo) {
    if (!isLoading.value &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      loadMoreItems(); // Daha fazla öğe yükle
    }
    return true;
  }
}

import 'package:diet_app_mobile/model/chat/chat_model.dart';
import 'package:diet_app_mobile/model/chat/message_model.dart';
import 'package:flutter/widgets.dart' show ScrollNotification;
import 'package:get/state_manager.dart';

class ChatViewController extends GetxController {
  var items = <ChatModel>[].obs; // Observable liste
  var isMenuOpen = false.obs; // Menü durumunu tutacak
  var activeFilterIndex = 0.obs;
  var isLoading = false.obs; // Loading durumu
  var hasMoreItems = true.obs; // Daha fazla öğe var mı?

  @override
  void onInit() {
    super.onInit();
    loadInitialItems(); // Başlangıçta öğeleri yükle
  }

  void loadInitialItems() {
    items.addAll(
      List.generate(
        10,
        (index) {
          return ChatModel(
            imageUrl: "person",
            lastChat:
                "Lorem impus dolat sit contact sit lorem impus dolar sit teacht contact.",
            name: "Furkan",
            surName: "Yıldırım",
            isOnline: index % 4 == 0 ? true : false,
            unReadMessageCount: 1,
            messages: List.generate(
              10,
              (index) => MessageModel(
                sender: index % 2 == 0 ? "Furkan Yıldırım" : "Sen",
                imageUrl: "person",
                name: "Furkan",
                surName: "Yıldırım",
                time: "2025-04-11 13:45:00.000",
                message:
                    "Lorem impus dolat sit contact sit lorem impus dolar sit teacht contact.",
              ),
            ),
          );
        },
      ),
    );
  }

  void toggleMenuOpen() {
    isMenuOpen.value = !isMenuOpen.value;
  }

  void toggleFilter(int index) {
    if (activeFilterIndex.value == index) {
      activeFilterIndex.value = -1; // Aynı butona tıklanırsa aktifliği kaldır
    } else {
      activeFilterIndex.value = index; // Aktif filtreyi değiştir
    }
  }

  bool onNotification(ScrollNotification scrollInfo) {
    if (!isLoading.value &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      loadMoreItems(); // Daha fazla öğe yükle
    }
    return true;
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
      items.addAll(
        List.generate(
          10,
          (index) => ChatModel(
            imageUrl: "person",
            lastChat:
                "Lorem impus dolat sit contact sit lorem impus dolar sit teacht contact.",
            name: "Furkan",
            surName: "Yıldırım",
            isOnline: index % 4 == 0 ? true : false,
            unReadMessageCount: 1,
            messages: List.generate(
              10,
              (index) => MessageModel(
                sender: "Furkan Yıldırım",
                imageUrl: "person",
                name: "Furkan",
                surName: "Yıldırım",
                time: "2025-04-11 13:45:00.000",
                message:
                    "Lorem impus dolat sit contact sit lorem impus dolar sit teacht contact.",
              ),
            ),
          ),
        ),
      );
    } else {
      hasMoreItems.value = false; // Daha fazla öğe yok
    }

    isLoading.value = false; // Loading durumunu bitir
  }

  String timeAgo(String timeString) {
    DateTime messageTime = DateTime.parse(timeString);
    Duration difference = DateTime.now().difference(messageTime);

    if (difference.inSeconds < 60) {
      return "az önce";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} dk önce";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} saat önce";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} gün önce";
    } else if (difference.inDays < 30) {
      return "${(difference.inDays / 7).floor()} hafta önce";
    } else if (difference.inDays < 365) {
      return "${(difference.inDays / 30).floor()} ay önce";
    } else {
      return "${(difference.inDays / 365).floor()} yıl önce";
    }
  }
}

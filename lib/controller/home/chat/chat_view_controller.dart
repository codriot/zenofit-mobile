import 'package:diet_app_mobile/model/chat/chat_model.dart';
import 'package:diet_app_mobile/model/chat/message_model.dart';
import 'package:flutter/material.dart' show TextEditingController;
import 'package:flutter/widgets.dart' show ScrollNotification;
import 'package:get/state_manager.dart';

class ChatViewController extends GetxController {
  var items = <ChatModel>[].obs; // Filtrelenmiş liste
  var allItems = <ChatModel>[].obs;  // Tüm liste
  var isMenuOpen = false.obs; 
  var activeFilterIndex = 0.obs;
  var isLoading = false.obs;
  var hasMoreItems = true.obs;
  final searchController = TextEditingController();
  var searchText = ''.obs;

  var isSearchActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialItems();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void filterItems() {
    final query = searchText.value;

    if (query.isEmpty) {
      items.assignAll(allItems);
    } else {
      final filtered = allItems.where((chat) {
        final fullName = "${chat.name} ${chat.surName}".toLowerCase();
        return fullName.contains(query);
      }).toList();

      items.assignAll(filtered);
    }
  }

  void searchChats(String query) {
    searchController.text = query;
    searchText.value = query.toLowerCase();
  }

  void loadInitialItems() {
    final initialData = List.generate(
      10,
      (index) {
        return ChatModel(
          imageUrl: "person",
          lastChat: "Lorem impus dolat sit contact sit lorem impus dolar sit teacht contact.",
          name: "Furkan",
          surName: "Yıldırım",
          isOnline: index % 4 == 0,
          unReadMessageCount: 1,
          messages: List.generate(
            10,
            (i) => MessageModel(
              sender: i % 2 == 0 ? "Furkan Yıldırım" : "Sen",
              imageUrl: "person",
              name: "Furkan",
              surName: "Yıldırım",
              time: "2025-04-11 13:45:00.000",
              message: "Lorem impus dolat sit contact sit lorem impus dolar sit teacht contact.",
            ),
          ),
        );
      },
    );

    allItems.assignAll(initialData);
    items.assignAll(initialData);
  }

  void toggleMenuOpen() {
    isMenuOpen.value = !isMenuOpen.value;
  }

  void toggleFilter(int index) {
    activeFilterIndex.value = activeFilterIndex.value == index ? -1 : index;
  }

  bool onNotification(ScrollNotification scrollInfo) {
    if (!isLoading.value &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      loadMoreItems();
    }
    return true;
  }

  void loadMoreItems() async {
    if (isLoading.value || !hasMoreItems.value) return;

    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));

    if (items.length < 100) {
      final moreItems = List.generate(
        10,
        (index) => ChatModel(
          imageUrl: "person",
          lastChat: "Lorem impus dolat sit contact sit lorem impus dolar sit teacht contact.",
          name: "Furkan",
          surName: "Yıldırım",
          isOnline: index % 4 == 0,
          unReadMessageCount: 1,
          messages: List.generate(
            10,
            (i) => MessageModel(
              sender: "Furkan Yıldırım",
              imageUrl: "person",
              name: "Furkan",
              surName: "Yıldırım",
              time: "2025-04-11 13:45:00.000",
              message: "Lorem impus dolat sit contact sit lorem impus dolar sit teacht contact.",
            ),
          ),
        ),
      );

      allItems.addAll(moreItems);
      filterItems(); // Arama varsa filtreleyerek ekle
    } else {
      hasMoreItems.value = false;
    }

    isLoading.value = false;
  }

  String timeAgo(String timeString) {
    final messageTime = DateTime.parse(timeString);
    final difference = DateTime.now().difference(messageTime);

    if (difference.inSeconds < 60) return "az önce";
    if (difference.inMinutes < 60) return "${difference.inMinutes} dk önce";
    if (difference.inHours < 24) return "${difference.inHours} saat önce";
    if (difference.inDays < 7) return "${difference.inDays} gün önce";
    if (difference.inDays < 30) return "${(difference.inDays / 7).floor()} hafta önce";
    if (difference.inDays < 365) return "${(difference.inDays / 30).floor()} ay önce";
    return "${(difference.inDays / 365).floor()} yıl önce";
  }
}

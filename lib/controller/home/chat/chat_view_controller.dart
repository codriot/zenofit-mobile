import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/model/chat/chat_model.dart';
import 'package:diet_app_mobile/model/chat/message_model.dart';
import 'package:diet_app_mobile/model/user_model.dart';
import 'package:flutter/material.dart' show TextEditingController;
import 'package:flutter/widgets.dart' show ScrollNotification;
import 'package:get/state_manager.dart';
import 'package:diet_app_mobile/API/services/general_serivce.dart';

class ChatViewController extends GetxController {
  var items = <ChatModel>[].obs;
  var allItems = <ChatModel>[].obs;
  var isMenuOpen = false.obs;
  var activeFilterIndex = 0.obs;
  var isLoading = false.obs;
  var hasMoreItems = true.obs;
  final searchController = TextEditingController();
  var searchText = ''.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var userCache = <int, UserModel>{}.obs;

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

  Future<UserModel?> getSenderUserInfo(int userId) async {
    // Önce cache'de kontrol et
    if (userCache.containsKey(userId)) {
      return userCache[userId];
    }

    try {
      final response = await GeneralService.instance.authorizedGet('/users/$userId');
      if (response != null && response.statusCode == 200) {
        final userData = UserModel.fromJson(response.data);
        // Cache'e ekle
        userCache[userId] = userData;
        return userData;
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
    return null;
  }

  Future<List<ChatModel>> _convertMessagesToChatModels(List<MessageModel> messages) async {
    // Mesajları gönderen ID'ye göre grupla
    final Map<int, List<MessageModel>> groupedMessages = {};
    for (var message in messages) {
      if (!groupedMessages.containsKey(message.senderId)) {
        groupedMessages[message.senderId] = [];
      }
      groupedMessages[message.senderId]!.add(message);
    }

    // Her grup için bir ChatModel oluştur
    List<ChatModel> chatModels = [];
    for (var entry in groupedMessages.entries) {
      final messages = entry.value;
      messages.sort((a, b) => b.sentAt.compareTo(a.sentAt));
      final lastMessage = messages.first;

      // Kullanıcı bilgilerini al
      final userInfo = await getSenderUserInfo(entry.key);

      chatModels.add(ChatModel(
        imageUrl: "person",
        name: userInfo?.name ?? "Kullanıcı ${entry.key}",
        surName: "",
        lastChat: lastMessage.messageContent,
        unReadMessageCount: messages.where((m) => m.senderId != StorageService.instance.loadUser()?.userId).length,
        messages: messages,
        isOnline: true,
        userId: entry.key,
      ));
    }
    return chatModels;
  }

  Future<void> loadInitialItems() async {
    try {
      isLoading.value = true;
      final response = await GeneralService.instance.authorizedGet('/messages/?page=1&page_size=10');

      if (response != null && response.statusCode == 200) {
        final data = response.data;
        final messages = (data['items'] as List)
            .map((item) => MessageModel.fromJson(item))
            .toList();

        final chatModels = await _convertMessagesToChatModels(messages);
        
        allItems.assignAll(chatModels);
        items.assignAll(chatModels);
        
        currentPage.value = data['page'];
        totalPages.value = data['pages'];
        hasMoreItems.value = currentPage.value < totalPages.value;
      }
    } catch (e) {
      print('Error loading messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filterItems() {
    final query = searchText.value.toLowerCase();
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

  Future<void> loadMoreItems() async {
    if (isLoading.value || !hasMoreItems.value) return;

    try {
      isLoading.value = true;
      final nextPage = currentPage.value + 1;
      
      final response = await GeneralService.instance.authorizedGet('/messages/?page=$nextPage&page_size=10');

      if (response != null && response.statusCode == 200) {
        final data = response.data;
        final messages = (data['items'] as List)
            .map((item) => MessageModel.fromJson(item))
            .toList();

        final newChatModels = await _convertMessagesToChatModels(messages);
        
        allItems.addAll(newChatModels);
        filterItems();
        
        currentPage.value = data['page'];
        totalPages.value = data['pages'];
        hasMoreItems.value = currentPage.value < totalPages.value;
      }
    } catch (e) {
      print('Error loading more messages: $e');
    } finally {
      isLoading.value = false;
    }
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

  void clearSearch() {
    searchText.value = "";
    searchController.clear();
    items.assignAll(allItems);
  }
}

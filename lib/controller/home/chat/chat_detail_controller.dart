import 'dart:async';
import 'package:diet_app_mobile/model/chat/message_model.dart';
import 'package:diet_app_mobile/model/user_model.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:flutter/cupertino.dart' show ScrollController, Widget;
import 'package:flutter/material.dart'
    show TextEditingController, showModalBottomSheet, Colors;
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:get/get.dart';
import 'package:diet_app_mobile/API/services/general_serivce.dart';
import 'package:diet_app_mobile/API/services/storage_service.dart';

class ChatDetailController extends GetxController {
  var messages = <MessageModel>[].obs;
  var isMenuOpen = false.obs;
  var isLoading = false.obs;
  late int senderId;
  late int currentUserId;
  var senderUser = Rxn<UserModel>();

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  Timer? _pollingTimer;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>;

    messages
        .assignAll(args['messages'] as List<MessageModel>? ?? <MessageModel>[]);
    senderUser.value = args['senderUser'] as UserModel?;

    senderId = senderUser.value?.userId ?? 0;

    loadCurrentUserId();
    _startPolling();
  }

  @override
  void onClose() {
    _pollingTimer?.cancel();
    super.onClose();
  }

  void _startPolling() {
    // Her 3 saniyede bir yeni mesajları kontrol et
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _checkNewMessages();
      print("Yeni mesajlar kontrol ediliyor...");
    });
  }

  Future<void> _checkNewMessages() async {
    try {
      final int chatPartnerId = 2; // Bu değeri dinamik olarak belirle

      final response = await GeneralService.instance.authorizedGet(
        '/messages/?sender_id=$currentUserId&receiver_id=$chatPartnerId',
      );

      if (response != null && response.statusCode == 200) {
        final data = response.data;
        final List<dynamic> messageList = data['items'] ?? [];

        final loadedMessages =
            messageList.map((item) => MessageModel.fromJson(item)).toList();

        // En yeniden en eskiye sırala
        loadedMessages.sort((a, b) => b.sentAt.compareTo(a.sentAt));

        bool hasNewMessage = false;

        for (var newMessage in loadedMessages) {
          final alreadyExists = messages.any((m) =>
              m.sentAt == newMessage.sentAt &&
              m.messageContent == newMessage.messageContent &&
              m.senderId == newMessage.senderId);

          if (!alreadyExists) {
            messages.insert(0, newMessage);
            hasNewMessage = true;
          }
        }

        if (hasNewMessage) {
          print('✅ Yeni mesaj(lar) eklendi.');
          _scrollToBottom();
        } else {
          print('⏳ Yeni mesaj yok.');
        }
      }
    } catch (e) {
      print('❌ Hata oluştu (mesaj kontrolünde): $e');
    }
  }

  void _scrollToBottom() {
    if (messages.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.jumpTo(scrollController.position.minScrollExtent);
      });
    }
  }

  void loadCurrentUserId() {
    final user = StorageService.instance.loadUser();
    if (user != null) {
      currentUserId = user.userId;
    } else {
      // Handle case where user is not logged in or user data is not available
      // Perhaps navigate to login or show an error
      print("Error: Current user ID not found!");
    }
  }

  Future<bool> sendMessage(String content) async {
    try {
      final response = await GeneralService.instance.authorizedPost(
        '/messages/',
        data: {
          'receiver_id': senderId,
          'message_content': content,
        },
      );

      if (response != null && response.statusCode == 200) {
        // Yeni mesajı direkt olarak ekle
        final newMessage = MessageModel.fromJson(response.data);
        messages.insert(0, newMessage);
        _scrollToBottom();
        return true;
      }
      return false;
    } catch (e) {
      print('Error sending message: $e');
      Get.snackbar(
        'Hata',
        'Mesaj gönderilemedi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }

  void toggleMenuOpen() {
    isMenuOpen.value = !isMenuOpen.value;
  }

  void showBlockUserBottomSheet(BuildContext context,
      {required Widget widget}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColor.transparent.getColor(),
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}

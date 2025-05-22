import 'package:diet_app_mobile/model/chat/message_model.dart';
import 'package:diet_app_mobile/model/user_model.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:flutter/cupertino.dart' show ScrollController, Widget;
import 'package:flutter/material.dart'
    show TextEditingController, showModalBottomSheet;
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

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>;

    messages.assignAll(args['messages'] as List<MessageModel>? ?? <MessageModel>[]);
    senderUser.value = args['senderUser'] as UserModel?;

    senderId = senderUser.value?.userId ?? 0;

    loadCurrentUserId();
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
        final newMessage = MessageModel.fromJson(response.data);
        messages.insert(0, newMessage);
        return true;
      }
      return false;
    } catch (e) {
      print('Error sending message: $e');
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

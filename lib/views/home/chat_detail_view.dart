import 'package:diet_app_mobile/controller/home/chat/chat_detail_controller.dart';
import 'package:diet_app_mobile/product/services/chrome_status_bar_service.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChatDetailView extends StatelessWidget {
  final ChatDetailController controller = Get.put(ChatDetailController());

  ChatDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    ChromeStatusBarService.setDarkStatusBar();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBarBody(context),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) =>
                      _buildOtherPersonChatContentContainer(index, context),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatActionButton(),
    );
  }

  Container _buildOtherPersonChatContentContainer(
      int index, BuildContext context) {
    return Container(
      margin: AppPadding.instance.bottomMedium,
      padding: AppPadding.instance.horizontalNormal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.orochimaru.getColor().withOpacity(0.6),
              image: DecorationImage(
                image: AssetImage(
                  AppImageUtility.getImagePath(
                      "${controller.messages[index].imageUrl}"),
                ),
              ),
            ),
          ),
          AppSpaces.instance.horizontal10,
          Padding(
            padding: AppPadding.instance.topNormal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.messages[index].sender}",
                  style: context.appGeneral.textTheme.labelLarge,
                ),
                Container(
                  padding: AppPadding.instance.allNormal,
                  constraints: BoxConstraints(
                    maxWidth: Get.width * 0.75,
                  ),
                  decoration: BoxDecoration(
                      color: AppColor.crystalBell.getColor().withOpacity(0.6),
                      borderRadius: BorderRadius.only(
                        topRight:
                            Radius.circular(AppSizes.instance.mediumValue),
                        bottomRight:
                            Radius.circular(AppSizes.instance.mediumValue),
                        bottomLeft:
                            Radius.circular(AppSizes.instance.mediumValue),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          Text("${controller.messages[index].message}"),
                        ],
                      ),
                    ],
                  ),
                ),
                AppSpaces.instance.vertical5,
                Text(
                    "${controller.messages[index].time?.split(" ")[1].substring(0, 5)}",
                    style: context.appGeneral.textTheme.bodySmall?.copyWith(
                        color: AppColor.black.getColor().withOpacity(0.6))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildFloatActionButton() {
    return Container(
      margin: AppPadding.instance.horizontalNormal,
      padding: AppPadding.instance.horizontalNormal,
      decoration: BoxDecoration(
        color: AppColor.orochimaru.getColor(),
        borderRadius: AppRadius.instance.normalBorderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: SvgPicture.asset(
              AppIconUtility.getIconPath("attachment-2",
                  format: IconFormat.svg),
              width: 32,
              height: 32,
            ),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController(),
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                hintText: "Bir mesaj yaz.",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10, // İçerik üst ve alt boşluğu
                ),
                hintStyle: TextStyle(color: Colors.grey), // Hint metin rengi
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  controller.sendMessage(value);
                }
              },
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(
              AppIconUtility.getIconPath("send-plane-fill",
                  format: IconFormat.svg),
              width: 32,
              color: AppColor.vividBlue.getColor().withOpacity(0.6),
              height: 32,
            ),
            onPressed: () {
              // Mesaj gönderme işlemi
            },
          ),
        ],
      ),
    );
  }

  Container _buildAppBarBody(BuildContext context) {
    return Container(
      height: Get.height * 0.08,
      color: AppColor.white.getColor(),
      child: Row(
        children: [
          const BackButton(),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.orochimaru.getColor(),
              image: DecorationImage(
                image: AssetImage(
                  (AppImageUtility.getImagePath("person")),
                ),
              ),
            ),
          ),
          Padding(
            padding: AppPadding.instance.leftNormal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dyt. Furkan Yıldırım",
                  style: context.appGeneral.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.green.getColor(),
                      ),
                    ),
                    AppSpaces.instance.horizontal5,
                    const Text("Online"),
                  ],
                )
              ],
            ),
          ),
          AppSpaces.instance.space,
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                  AppIconUtility.getIconPath("more-2", format: IconFormat.svg)))
        ],
      ),
    );
  }
}

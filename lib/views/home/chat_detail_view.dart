import 'package:diet_app_mobile/controller/home/chat/chat_detail_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/chrome_status_bar_service.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_duration.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:diet_app_mobile/views/home/aboned_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChatDetailView extends StatelessWidget {
  final ChatDetailController controller = Get.put(ChatDetailController());
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  ChatDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    ChromeStatusBarService.setDarkStatusBar();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildAppBarBody(context),
                AppSpaces.instance.vertical10,
                _buildChatLvbBubbleContainers(),
                AppSpaces.instance.vertical50,
              ],
            ),
            _buildPageRecommendedFilter(context),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatActionButton(context),
    );
  }

  Positioned _buildPageRecommendedFilter(BuildContext context) {
    return Positioned(
      top: 50,
      right: AppSizes.instance.normalValue,
      child: Obx(
        () => AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            width: Get.width * 0.4,
            height: controller.isMenuOpen.value ? Get.height * 0.18 : 0,
            decoration: BoxDecoration(
              color: AppColor.black.getColor().withAlpha(200),
              borderRadius: AppRadius.instance.normalBorderRadius,
            ),
            child: controller.isMenuOpen.value
                ? ClipRRect(
                    borderRadius: AppRadius.instance.normalBorderRadius,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildFilterButtonComponent(
                          onPressed: () {NavigatorController.instance.pushToPage(NavigateRoutesItems.dietitionComplain);},
                          context: context,
                          text: "Şikayet Et",
                          trailingIcon: "error-warning-line",
                          iconColor: AppColor.red.getColor(),
                          textColor: AppColor.red.getColor(),
                        ),
                        _buildFilterButtonComponent(
                          onPressed: () {},
                          context: context,
                          text: "Profil",
                          trailingIcon: "star-fill",
                          iconColor: AppColor.goldenGlam.getColor(),
                        ),
                        _buildFilterButtonComponent(
                          onPressed: () {controller.showBlockUserBottomSheet(context,widget: const AbonedView());},
                          context: context,
                          text: "Engelle",
                          trailingIcon: "forbid-line",
                          iconColor: AppColor.red.getColor(),
                          textColor: AppColor.red.getColor(),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButtonComponent({
    required BuildContext context,
    required String text,
    required String trailingIcon,
    Color? textColor,
    Color? iconColor,
    required void Function() onPressed,
  }) {
    return CustomElevatedButton(
      onPressed: onPressed,
      elevation: 0,
      backgroundColor: AppColor.transparent.getColor(),
      width: double.infinity,
      child: Padding(
        padding: AppPadding.instance.allSmall,
        child: Row(
          children: [
            AppSpaces.instance.horizontal10,
            Text(
              text,
              style: context.appGeneral.textTheme.bodyLarge?.copyWith(
                  color: textColor ?? AppColor.white.getColor(),
                  fontWeight: FontWeight.w500),
            ),
            AppSpaces.instance.space,
            SvgPicture.asset(
              AppIconUtility.getIconPath(trailingIcon, format: IconFormat.svg),
              color: iconColor ?? AppColor.white.getColor(),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildChatLvbBubbleContainers() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          reverse: true,
          controller: scrollController,
          itemCount: controller.messages.length,
          itemBuilder: (context, index) {
            return AnimatedOpacity(
              opacity: 1.0,
              duration: AppDuration.instance.durationFast,
              child: controller.messages[index].sender != "Sen"
                  ? _buildOtherPersonChatContentContainer(index, context)
                  : _buildYourChatContentContainer(index, context),
            );
          },
        );
      }),
    );
  }

  void _sendMessage(String message) {
    if (message.isNotEmpty) {
      controller.sendMessage(message);
      messageController.clear();
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.jumpTo(scrollController.position.minScrollExtent);
      });
    }
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
                  width:
                      Get.width - (AppSizes.instance.normalValue * 2 + 40 + 10),
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
                  controller.messages[index].time != null &&
                          controller.messages[index].time!.contains(" ")
                      ? "${controller.messages[index].time!.split(" ")[1].substring(0, 5)}"
                      : '00:00',
                  style: context.appGeneral.textTheme.bodySmall?.copyWith(
                      color: AppColor.black.getColor().withOpacity(0.6)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildYourChatContentContainer(int index, BuildContext context) {
    return Container(
      margin: AppPadding.instance.bottomMedium,
      padding: AppPadding.instance.horizontalNormal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppPadding.instance.topNormal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${controller.messages[index].sender}",
                  style: context.appGeneral.textTheme.labelLarge,
                ),
                Container(
                  padding: AppPadding.instance.allNormal,
                  width:
                      Get.width - (AppSizes.instance.normalValue * 2 + 40 + 10),
                  decoration: BoxDecoration(
                      color: AppColor.vividBlue.getColor().withOpacity(0.6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSizes.instance.mediumValue),
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
                          Text(
                            "${controller.messages[index].message} $index",
                            style: context.appGeneral.textTheme.bodyMedium
                                ?.copyWith(color: AppColor.white.getColor()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppSpaces.instance.vertical5,
                Text(
                  controller.messages[index].time != null &&
                          controller.messages[index].time!.contains(" ")
                      ? controller.messages[index].time!
                          .split(" ")[1]
                          .substring(0, 5)
                      : '00:00',
                  style: context.appGeneral.textTheme.bodySmall?.copyWith(
                      color: AppColor.black.getColor().withOpacity(0.6)),
                ),
              ],
            ),
          ),
          AppSpaces.instance.horizontal10,
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
        ],
      ),
    );
  }

  Container _buildFloatActionButton(BuildContext context) {
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
              controller: messageController,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                hintText: "Bir mesaj yaz.",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onSubmitted: (value) {
                _sendMessage(value);
                FocusScope.of(context).unfocus();
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
              _sendMessage(messageController.text);
              FocusScope.of(context).unfocus();
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
              onPressed: () {
                controller.toggleMenuOpen();
              },
              icon: SvgPicture.asset(
                  AppIconUtility.getIconPath("more-2", format: IconFormat.svg)))
        ],
      ),
    );
  }
}

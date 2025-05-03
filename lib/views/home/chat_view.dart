import 'package:diet_app_mobile/controller/home/chat/chat_view_controller.dart'
    show ChatViewController;
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  final ChatViewController controller = Get.put(ChatViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Padding(
              padding: AppPadding.instance.horizontalNormal,
              child: Obx(() {
                return NotificationListener<ScrollNotification>(
                  onNotification: controller.onNotification,
                  child: ListView(
                    children: [
                      _buildPageAppBar(context),
                      _buildSearchBar(),
                      AppSpaces.instance.vertical10,
                      _buildListGenerateChatCard(context),
                      if (controller.isLoading.value)
                        _buildPageCircleProgressBar(),
                    ],
                  ),
                );
              }),
            ),
            _buildPageRecommendedFilter(context),
          ],
        ),
      ),
    );
  }

  Column _buildListGenerateChatCard(BuildContext context) {
    return Column(
      children: List.generate(
        controller.items.length,
        (index) => _buildChatCardButton(index, context),
      ),
    );
  }

  Padding _buildChatCardButton(int index, BuildContext context) {
    return Padding(
      padding: AppPadding.instance.bottomNormal,
      child: InkWell(
        onTap: () {
          NavigatorController.instance.pushToPage(
              NavigateRoutesItems.chatDetail,
              arguments: controller.items[index].messages);
        },
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.crystalBell.getColor(),
                  image: DecorationImage(
                    image: AssetImage(
                      AppImageUtility.getImagePath(
                        "${controller.items[index].imageUrl}",
                      ),
                    ),
                  ),
                ),
              ),
              AppSpaces.instance.horizontal10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dyt. ${controller.items[index].name} ${controller.items[index].surName}",
                          style: context.appGeneral.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          controller.timeAgo(
                              "${controller.items[index].messages?.last.time}"),
                          style: context.appGeneral.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${controller.items[index].messages?.last.message}",
                            style: context.appGeneral.textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        AppSpaces.instance.horizontal10,
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                AppColor.vividBlue.getColor().withOpacity(0.6),
                          ),
                          child: Text(
                            "${controller.items[index].unReadMessageCount}",
                            style: context.appGeneral.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppColor.white.getColor(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildPageAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomElevatedButton(
          backgroundColor: AppColor.transparent.getColor(),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          height: 40,
          width: 40,
          onPressed: Get.back,
          child: SvgPicture.asset(
            AppIconUtility.getIconPath(
              "arrow-left",
              format: IconFormat.svg,
            ),
            width: AppSizes.instance.iconSizeNormal,
            height: AppSizes.instance.iconSizeNormal,
          ),
        ),
        Text(
          "Mesajlar",
          style: context.appGeneral.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpaces.instance.horizontal40,
      ],
    );
  }

  Positioned _buildPageRecommendedFilter(BuildContext context) {
    return Positioned(
      top: 120,
      right: AppSizes.instance.normalValue,
      child: Obx(
        () => AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            width: Get.width * 0.56,
            height: controller.isMenuOpen.value ? Get.height * 0.16 : 0,
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
                        Text(
                          "Önerilen Filtreleme",
                          style: context.appGeneral.textTheme.bodyMedium
                              ?.copyWith(color: AppColor.white.getColor()),
                        ),
                        _buildFilterButtonComponent(
                          context: context,
                          isActive: controller.activeFilterIndex.value == 0,
                          text: "Senin için",
                          trailingIcon: "account-circle-line",
                          index: 0,
                        ),
                        _buildFilterButtonComponent(
                          context: context,
                          isActive: controller.activeFilterIndex.value == 1,
                          text: "Kişileştirilmemiş",
                          trailingIcon: "earth-line",
                          index: 1,
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

  Padding _buildPageCircleProgressBar() {
    return Padding(
      padding: AppPadding.instance.bottomNormal,
      child: const SizedBox(
        height: 56,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildFilterButtonComponent({
    required BuildContext context,
    required String text,
    required String trailingIcon,
    required bool isActive,
    required int index,
  }) {
    return CustomElevatedButton(
      onPressed: () {
        controller.toggleFilter(index);
      },
      elevation: 0,
      backgroundColor: AppColor.transparent.getColor(),
      width: double.infinity,
      child: Padding(
        padding: AppPadding.instance.topSmall,
        child: Row(
          children: [
            isActive
                ? SvgPicture.asset(
                    AppIconUtility.getIconPath("check-line",
                        format: IconFormat.svg),
                    color: AppColor.white.getColor(),
                  )
                : const SizedBox(width: 24),
            AppSpaces.instance.horizontal10,
            Text(
              text,
              style: context.appGeneral.textTheme.bodyLarge?.copyWith(
                  color: AppColor.white.getColor(),
                  fontWeight: FontWeight.w500),
            ),
            AppSpaces.instance.space,
            SvgPicture.asset(
              AppIconUtility.getIconPath(trailingIcon, format: IconFormat.svg),
              color: AppColor.white.getColor(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        CustomTextField(
          width: Get.width - 40 - (AppSizes.instance.normalValue * 2),
          hintText: "Arama yapın",
          controller: controller.searchController,
          showSearchIcon: true,
          padding: EdgeInsets.zero,
          height: 40,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Lütfen bir değer girin';
            }
            return null;
          },
          onChange: (query) {
            controller.searchChats(query ?? "");
            controller.filterItems();
          },
          onSubmit: (value) {
            FocusScope.of(Get.context!)
                .unfocus(); // Enter'a basınca klavyeyi kapat
          },
        ),
        CustomElevatedButton(
          backgroundColor: AppColor.transparent.getColor(),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          height: 40,
          width: 40,
          child: SvgPicture.asset(
            AppIconUtility.getIconPath("more", format: IconFormat.svg),
          ),
          onPressed: () {
            controller.toggleMenuOpen();
          },
        ),
      ],
    );
  }
}

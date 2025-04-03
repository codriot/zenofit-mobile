// lib/views/discover/discover_view.dart
import 'package:diet_app_mobile/controller/dietition/dietition_view_controller.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DietitionView extends StatelessWidget {
  final DietitionViewController controller = Get.put(DietitionViewController());
  DietitionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.closeMenuAndDietitionInfoStates,
      child: Scaffold(
        backgroundColor: AppColor.whiteSolid.getColor(),
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            //body de gözükücek componentler
            Padding(
              padding: AppPadding.instance.horizontalNormal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpaces.instance.vertical10,
                  _buildDietitionMenuLvb(),
                  _buildAdviceDietitionsText(context),
                  AppSpaces.instance.vertical10,
                  _buildDietitionCardLvb(),
                ],
              ),
            ),
            _buildFilterAnimatedSize(context),
          ],
        ),
      ),
    );
  }

  Expanded _buildDietitionCardLvb() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
          padding: AppPadding.instance.bottomNormal,
          child: _buildDietitionCard(context, index),
        ),
      ),
    );
  }

  SizedBox _buildDietitionMenuLvb() {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.menuItems.length,
        itemBuilder: (context, index) => _builDietitionMenuCard(index, context),
      ),
    );
  }

  Widget _builDietitionMenuCard(int index, BuildContext context) {
    return GestureDetector(
      onTap: () => controller.toggleMenuItem(index),
      child: Obx(
        () => Container(
          margin: index == (controller.menuItems.length - 1)
              ? EdgeInsets.zero
              : AppPadding.instance.rightNormal,
          padding: AppPadding.instance.horizontalMedium,
          height: 64,
          decoration: BoxDecoration(
            color: AppColor.crystalBell.getColor(),
            borderRadius: AppRadius.instance.normalBorderRadius,
            border: Border.all(
              color: controller.menuItems[index].isSelected
                  ? AppColor.vividBlue.getColor()
                  : AppColor.crystalBell.getColor(),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                AppIconUtility.getIconPath(
                  controller.menuItems[index].iconUrl,
                  format: IconFormat.png,
                ),
              ),
              AppSpaces.instance.horizontal5,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.menuItems[index].title,
                    style: context.appGeneral.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${controller.menuItems[index].dietitionCount} Diyetisyen mevcut",
                    style: context.appGeneral.textTheme.bodyMedium?.copyWith(
                      color: AppColor.lucentLime.getColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDietitionCard(BuildContext context, int index) {
    return Stack(
      children: [
        InkWell(
          onTap: (){
            NavigatorController.instance.pushToPage(NavigateRoutesItems.dietitionDetail,
            arguments: controller.dietitions[index]);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppRadius.instance.normalBorderRadius,
              boxShadow: [
                BoxShadow(
                  color: AppColor.crystalBell.getColor(),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            width: double.infinity,
            padding: AppPadding.instance.allSmall,
            height: 90,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColor.crystalBell.getColor(),
                      borderRadius: AppRadius.instance.normalBorderRadius),
                  width: 90 - AppSizes.instance.normalValue,
                  height: 90 - AppSizes.instance.normalValue,
                  child: Image.asset(AppImageUtility.getImagePath("person")),
                ),
                AppSpaces.instance.horizontal10,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dyt. ${controller.dietitions[index].name} ${controller.dietitions[index].lastName}",
                      style: context.appGeneral.textTheme.titleSmall,
                    ),
                    Text("${controller.dietitions[index].workBranch}",
                        style: context.appGeneral.textTheme.labelLarge?.copyWith(
                          color: AppColor.grey.getColor(),
                        )),
                    Row(
                      children: [
                        Text(
                          (controller.dietitions[index].isAvaible ?? false)
                              ? "Müsait"
                              : "Müsait Değil",
                          style: context.appGeneral.textTheme.labelLarge
                              ?.copyWith(
                                  color:
                                      (controller.dietitions[index].isAvaible ??
                                              false)
                                          ? AppColor.lucentLime.getColor()
                                          : AppColor.red.getColor(),
                                  fontWeight: FontWeight.bold,
                                  decoration:
                                      (controller.dietitions[index].isAvaible ??
                                              false)
                                          ? TextDecoration.none
                                          : TextDecoration.lineThrough),
                        ),
                        AppSpaces.instance.horizontal5,
                        SvgPicture.asset(
                          AppIconUtility.getIconPath("star-fill",
                              format: IconFormat.svg),
                          width: 16,
                          height: 16,
                        ),
                        AppSpaces.instance.horizontal5,
                        Text(
                          "${controller.dietitions[index].rating}",
                          style:
                              context.appGeneral.textTheme.labelLarge?.copyWith(
                            color: AppColor.black.getColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                AppSpaces.instance.space,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomElevatedButton(
                      elevation: 0,
                      onPressed: () => controller.toggleFavorite(index),
                      width: 32,
                      height: 32,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      backgroundColor: AppColor.transparent.getColor(),
                      child: Obx(
                        () => SvgPicture.asset(
                          AppIconUtility.getIconPath(
                            controller.favoriteStates[index]
                                ? "heart-fill"
                                : "heart-line",
                            format: IconFormat.svg,
                          ),
                          color: controller.favoriteStates[index]
                              ? AppColor.red.getColor()
                              : AppColor.black.getColor(),
                        ),
                      ),
                    ),
                    CustomElevatedButton(
                      backgroundColor: AppColor.transparent.getColor(),
                      elevation: 0,
                      onPressed: () {
                        controller.toggleDietitionInfoStateItem(index);
                      },
                      width: 32,
                      height: 32,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      child: SvgPicture.asset(AppIconUtility.getIconPath("more-2",
                          format: IconFormat.svg)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        _buildComplainAnimatedSize(context, index),
      ],
    );
  }

  Positioned _buildComplainAnimatedSize(BuildContext context, int index) {
    return Positioned(
      right: AppSizes.instance.normalValue,
      child: Obx(
        () => AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            width: Get.width * 0.56,
            height:
                controller.dietitionInfoStates[index] ? Get.height * 0.16 : 0,
            decoration: BoxDecoration(
              color: AppColor.black.getColor().withAlpha(200),
              borderRadius: AppRadius.instance.normalBorderRadius,
            ),
            child: controller.dietitionInfoStates[index]
                ? ClipRRect(
                    borderRadius: AppRadius.instance.normalBorderRadius,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: AppSizes.instance.normalValue,
                        right: AppSizes.instance.normalValue,
                        left: AppSizes.instance.normalValue,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildComplainButtonComponent(
                            buttonIcon: "error-warning-line",
                            buttonText: "Şikayet Et",
                            context: context,
                            onTap: () {},
                            color: AppColor.red.getColor(),
                          ),
                          AppSpaces.instance.vertical5,
                          _buildComplainButtonComponent(
                            buttonIcon: "star-fill",
                            buttonText: "Diyetisyeni puanla",
                            context: context,
                            onTap: () {},
                            color: AppColor.white.getColor(),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }

  Widget _buildComplainButtonComponent({
    required BuildContext context,
    required String buttonText,
    required String buttonIcon,
    required void Function() onTap,
    required Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            buttonText,
            style: context.appGeneral.textTheme.bodyLarge?.copyWith(
                color: color ?? AppColor.red.getColor(),
                fontWeight: FontWeight.w500),
          ),
          AppSpaces.instance.space,
          SvgPicture.asset(
            AppIconUtility.getIconPath(buttonIcon, format: IconFormat.svg),
          ),
        ],
      ),
    );
  }

  Text _buildAdviceDietitionsText(BuildContext context) {
    return Text(
      "Tavsiye Edilen Diyetisyenler",
      style: context.appGeneral.textTheme.titleMedium
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Positioned _buildFilterAnimatedSize(BuildContext context) {
    return Positioned(
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

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColor.transparent.getColor(),
      automaticallyImplyLeading: false,
      title: CustomTextField(
        hintText: "Arama yapın",
        controller: TextEditingController(),
        showSearchIcon: true,
        height: 40,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Lütfen bir değer girin';
          }
          return null;
        },
        onSaved: (value) {
          // Değer kaydedildiğinde yapılacak işlemler
        },
        onSubmit: (value) {
          // Metin alanında "enter" tuşuna basıldığında yapılacak işlemler
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 8),
          child: CustomElevatedButton(
              backgroundColor: AppColor.transparent.getColor(),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                AppIconUtility.getIconPath("filter-3-line",
                    format: IconFormat.svg),
              ),
              onPressed: () {
                controller.toggleMenuOpen();
              }),
        )
      ],
    );
  }
}

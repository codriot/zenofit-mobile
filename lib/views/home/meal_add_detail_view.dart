import 'package:diet_app_mobile/controller/home/meal/meal_add_detail_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:diet_app_mobile/product/widgets/general/wave_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diet_app_mobile/product/widgets/charts/isometric_bar_widget.dart';

class MealAddDetailView extends GetView<MealAddDetailController> {
  const MealAddDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          return SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: AppPadding.instance.horizontalNormal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context),
                      _buildPageHeader(context),
                      _buildRecomendedTitleText(context),
                      AppSpaces.instance.vertical5,
                    ],
                  ),
                ),
                WaveCardWidget(
                  width: double.infinity,
                  backgroundColor: AppColor.white.getColor(),
                  padding: AppPadding.instance.allNormal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppSpaces.instance.vertical25,
                      _buildRecommendedMeals(context),
                      AppSpaces.instance.vertical25,
                      _buildMacronutrients(context),
                      AppSpaces.instance.vertical25,
                      _buildAddButton(context),
                      AppSpaces.instance.vertical20,
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        Expanded(
          child: Center(
            child: Text(
              controller.selectedMeal.value?.title ?? '',
              style: context.appGeneral.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 40), // Simetri için sağ tarafta boşluk
      ],
    );
  }

  SizedBox _buildPageHeader(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(
            controller.selectedMeal.value?.subtitle ?? 'Önerilen Öğün',
            style: context.appGeneral.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Positioned(
            right: -30,
            top: -60,
            child: Image.asset(
              AppImageUtility.getImagePath(
                  controller.selectedMeal.value?.imageKey ?? '',
                  format: ImageFormat.png),
              width: 100,
              height: 100,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRecomendedTitleText(BuildContext context) {
    return Text(
      'Önerilen ve Eklenen ${controller.selectedMeal.value?.title ?? ''}',
      style: context.appGeneral.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRecommendedMeals(BuildContext context) {
    return Obx(() {
      if (controller.selectedMeal.value == null) return const SizedBox();

      return Column(
        children: List.generate(
          controller.selectedMeal.value!.recommendedContents.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: _buildMealItem(context, index),
          ),
        ),
      );
    });
  }

  Widget _buildMealItem(BuildContext context, int index) {
    return Obx(() {
      final content = controller.selectedMeal.value!.recommendedContents[index];
      final isSelected = content.isSelected;

      return Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: content.backgroundColor,
                borderRadius: AppRadius.instance.normalBorderRadius,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: AppPadding.instance.leftMedium,
                    child: InkWell(
                      onTap: () => controller.selectMealContent(index),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColor.transparent.getColor(),
                          borderRadius: AppRadius.instance.smallBorderRadius,
                          border: Border.all(
                            width: 2,
                            color: AppColor.white.getColor(),
                          ),
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                color: AppColor.white.getColor(),
                              )
                            : const SizedBox(),
                      ),
                    ),
                  ),
                  AppSpaces.instance.horizontal10,
                  Expanded(
                    child: Center(
                      child: Text(
                        content.title,
                        style:
                            context.appGeneral.textTheme.bodyMedium?.copyWith(
                          color: AppColor.white.getColor(),
                          decoration: isSelected
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: content.backgroundColor,
                borderRadius: AppRadius.instance.normalBorderRadius,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNutrientIcon(context, 'carbs', content.carbsText),
                  AppSpaces.instance.horizontal10,
                  _buildNutrientIcon(context, 'protein', content.proteinText),
                  AppSpaces.instance.horizontal10,
                  _buildNutrientIcon(context, 'fat', content.fatText),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildNutrientIcon(BuildContext context, String type, String value) {
    String icon;
    switch (type) {
      case 'carbs':
        icon = 'carbs';
        break;
      case 'protein':
        icon = 'protein';
        break;
      case 'fat':
        icon = 'fat';
        break;
      default:
        icon = 'carbs';
    }

    return Row(
      children: [
        AppSpaces.instance.horizontal5,
        Image.asset(
          AppIconUtility.getIconPath(icon, format: IconFormat.png),
          color: Colors.black87,
        ),
        Text(
          ":$value",
          style: context.appGeneral.textTheme.bodyMedium?.copyWith(
            color: AppColor.white.getColor(),
          ),
        ),
      ],
    );
  }

  Widget _buildMacronutrients(BuildContext context) {
    return Obx(() {
      final macros = controller.getTotalMacros();

      return Container(
        width: double.infinity,
        padding: AppPadding.instance.allNormal,
        decoration: BoxDecoration(
          color: AppColor.white.getColor(),
          borderRadius: AppRadius.instance.halfBorderRadius,
          boxShadow: [
            BoxShadow(
              color: AppColor.crystalBell.getColor(),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Toplam Öğün Miktarları',
              style: context.appGeneral.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpaces.instance.vertical25,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMacronutrientItem(
                  context,
                  'Karbonhidrat',
                  '${macros['carbs']?['percentage']}%',
                  '${macros['carbs']?['amount']}g',
                  'carbs',
                ),
                _buildMacronutrientItem(
                  context,
                  'Protein',
                  '${macros['protein']?['percentage']}%',
                  '${macros['protein']?['amount']}g',
                  'protein',
                ),
                _buildMacronutrientItem(
                  context,
                  'Yağ',
                  '${macros['fat']?['percentage']}%',
                  '${macros['fat']?['amount']}g',
                  'fat',
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMacronutrientItem(
    BuildContext context,
    String title,
    String percentage,
    String amount,
    String icon,
  ) {
    // Yüzde değerini double'a çevirme
    final percentageValue =
        double.tryParse(percentage.replaceAll('%', '')) ?? 0;

    return Expanded(
      child: Row(
        children: [
          SizedBox(
            height: 100,
            child: IsometricBarWidget(
              height: 80,
              width: 30,
              topColor: Colors.grey[300]!,
              frontColor: Colors.blue,
              fillPercentage: percentageValue / 100,
              duration: const Duration(milliseconds: 500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                  child: Image.asset(
                    AppIconUtility.getIconPath(icon, format: IconFormat.png),
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: Text(title,
                      style: context.appGeneral.textTheme.bodyMedium),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      percentage,
                      style: context.appGeneral.textTheme.bodyMedium?.copyWith(
                        color: AppColor.vividBlue.getColor(),
                      ),
                    ),
                    AppSpaces.instance.horizontal5,
                    Text(
                      "($amount)",
                      style: context.appGeneral.textTheme.bodyMedium?.copyWith(
                        color: AppColor.grey.getColor(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return CustomElevatedButton(
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.instance.halfBorderRadius,
      ),
      onPressed: () {
        NavigatorController.instance.pushToPage(
          NavigateRoutesItems.addMealFilterSearch,
        );
      },
      width: double.infinity,
      height: Get.height * 0.07,
      backgroundColor: AppColor.noxious.getColor(),
      child: Text(
        '+ Yemek Ekle',
        style: context.appGeneral.textTheme.titleLarge?.copyWith(
          color: AppColor.white.getColor(),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

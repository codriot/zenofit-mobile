import 'package:diet_app_mobile/controller/basic/meal/meal_add_detail_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealAddDetailView extends GetView<MealAddDetailController> {
  const MealAddDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: AppPadding.instance.allNormal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            AppSpaces.instance.vertical25,
            _buildRecommendedMeals(context),
            AppSpaces.instance.vertical25,
            _buildMacronutrients(context),
            AppSpaces.instance.vertical25,
            _buildAddButton(context),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Obx(() => Text(
        controller.selectedMeal.value?.title ?? '',
        style: context.appGeneral.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
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
          Obx(() => Text(
            'Önerilen ve Eklenen ${controller.selectedMeal.value?.title ?? ''}lar',
            style: context.appGeneral.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          )),
        ],
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
    final content = controller.selectedMeal.value!.recommendedContents[index];
    return InkWell(
      onTap: () => controller.selectMealContent(index),
      child: Container(
        padding: AppPadding.instance.allNormal,
        decoration: BoxDecoration(
          color: content.isSelected
              ? AppColor.noxious.getColor().withOpacity(0.1)
              : AppColor.white.getColor(),
          borderRadius: AppRadius.instance.halfBorderRadius,
          border: Border.all(
            color: content.isSelected
                ? AppColor.noxious.getColor()
                : AppColor.crystalBell.getColor(),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content.title,
              style: context.appGeneral.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpaces.instance.vertical10,
            Row(
              children: [
                _buildNutrientInfo(context, 'Protein', content.proteinText),
                AppSpaces.instance.horizontal15,
                _buildNutrientInfo(context, 'Karbonhidrat', content.carbsText),
                AppSpaces.instance.horizontal15,
                _buildNutrientInfo(context, 'Yağ', content.fatText),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientInfo(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.appGeneral.textTheme.bodyMedium?.copyWith(
            color: AppColor.grey.getColor(),
          ),
        ),
        Text(
          value,
          style: context.appGeneral.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMacronutrients(BuildContext context) {
    return Obx(() {
      final macros = controller.getTotalMacros();
      
      return Container(
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
            AppSpaces.instance.vertical15,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMacronutrientItem(
                  context,
                  'Karbonhidrat',
                  '${macros['carbs']['percentage']}%',
                  '${macros['carbs']['amount']}g',
                ),
                _buildMacronutrientItem(
                  context,
                  'Protein',
                  '${macros['protein']['percentage']}%',
                  '${macros['protein']['amount']}g',
                ),
                _buildMacronutrientItem(
                  context,
                  'Yağ',
                  '${macros['fat']['percentage']}%',
                  '${macros['fat']['amount']}g',
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
  ) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColor.bleachedSilk.getColor(),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              percentage,
              style: context.appGeneral.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColor.noxious.getColor(),
              ),
            ),
          ),
        ),
        AppSpaces.instance.vertical10,
        Text(
          title,
          style: context.appGeneral.textTheme.bodyMedium?.copyWith(
            color: AppColor.grey.getColor(),
          ),
        ),
        Text(
          amount,
          style: context.appGeneral.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        // Yemek ekleme işlemi
        Get.back();
      },
      width: double.infinity,
      height: 50,
      backgroundColor: AppColor.noxious.getColor(),
      child: Text(
        'Yemek Ekle',
        style: context.appGeneral.textTheme.titleMedium?.copyWith(
          color: AppColor.white.getColor(),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
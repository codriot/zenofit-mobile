import 'package:diet_app_mobile/controller/basic/meal/meal_add_filter_search_detail_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealAddFilterSearchDetailView extends GetView<MealAddFilterSearchDetailController> {
  const MealAddFilterSearchDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: AppPadding.instance.allNormal,
                child: Column(
                  children: [
                    _buildNutrientInput(
                      context,
                      'Öğün Adı',
                      'Öğün adını girin',
                      controller.nameController,
                      TextInputType.text,
                    ),
                    _buildNutrientInput(
                      context,
                      'Kalori Miktarı',
                      'Kalori miktarını gir',
                      controller.calorieController,
                      TextInputType.number,
                    ),
                    _buildNutrientInput(
                      context,
                      'Yağ',
                      'Yağ miktarını gir',
                      controller.fatController,
                      TextInputType.number,
                    ),
                    _buildNutrientInput(
                      context,
                      'Karbonhidrat',
                      'Karbonhidrat miktarını gir',
                      controller.carbController,
                      TextInputType.number,
                    ),
                    _buildNutrientInput(
                      context,
                      'Protein',
                      'Protein miktarını gir',
                      controller.proteinController,
                      TextInputType.number,
                    ),
                    AppSpaces.instance.vertical25,
                    _buildMacroCards(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: AppPadding.instance.horizontalNormal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              NavigatorController.instance.pop();
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                'Öğün Detayı',
                style: context.appGeneral.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.check,
              color: AppColor.vividBlue.getColor(),
            ),
            onPressed: controller.onSavePressed,
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientInput(
    BuildContext context,
    String label,
    String hint,
    TextEditingController textController,
    TextInputType keyboardType,
  ) {
    return Padding(
      padding: AppPadding.instance.bottomNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.appGeneral.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            style: context.appGeneral.textTheme.titleMedium?.copyWith(
              color: AppColor.vividBlue.getColor(),
            ),
            controller: textController,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: AppRadius.instance.normalBorderRadius,
                borderSide: BorderSide(
                  color: AppColor.crystalBell.getColor(),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppRadius.instance.normalBorderRadius,
                borderSide: BorderSide(
                  color: AppColor.crystalBell.getColor(),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppRadius.instance.normalBorderRadius,
                borderSide: BorderSide(
                  color: AppColor.vividBlue.getColor(),
                ),
              ),
              filled: true,
              fillColor: AppColor.white.getColor(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroCards(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Besin Değerleri',
          style: context.appGeneral.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpaces.instance.vertical15,
        Obx(() => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildNutritionCard(
                      'Kalori',
                      '${controller.calories.value} Cal',
                      AppColor.noxious.getColor(),
                      context),
                ),
                AppSpaces.instance.horizontal10,
                Expanded(
                  child: _buildNutritionCard(
                      'Protein',
                      '${controller.protein.value} g',
                      AppColor.sweetPatato.getColor(),
                      context),
                ),
              ],
            ),
            AppSpaces.instance.vertical10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildNutritionCard(
                      'Karbonhidrat',
                      '${controller.carbs.value} g',
                      AppColor.vividBlue.getColor(),
                      context),
                ),
                AppSpaces.instance.horizontal10,
                Expanded(
                  child: _buildNutritionCard(
                      'Yağ',
                      '${controller.fat.value} g',
                      AppColor.vaporwaweBlue.getColor(),
                      context),
                ),
              ],
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildNutritionCard(
      String title, String value, Color color, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color,
                    width: 4,
                  ),
                ),
              ),
              AppSpaces.instance.horizontal10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.appGeneral.textTheme.titleSmall?.copyWith(
                      color: AppColor.grey.getColor(),
                    ),
                  ),
                  Text(
                    value,
                    style: context.appGeneral.textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

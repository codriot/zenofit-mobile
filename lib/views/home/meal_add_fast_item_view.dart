import 'package:diet_app_mobile/controller/home/meal/meal_add_fast_item_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealAddFastItemView extends GetView<MealAddFastItemController> {
  const MealAddFastItemView({super.key});

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
                'Hızlı Ekle',
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
}
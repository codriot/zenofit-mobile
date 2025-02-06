import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class MealAddView extends StatelessWidget {
  const MealAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Öğün Ekle',
          style: context.appGeneral.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.instance.horizontalNormal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressSection(context),
            AppSpaces.instance.vertical20,
            _buildMealList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
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
            'Bugün, 8 Haziran',
            style: context.appGeneral.textTheme.bodyLarge?.copyWith(
              color: AppColor.grey.getColor(),
            ),
          ),
          Row(
            children: [
              Text(
                '30',
                style: context.appGeneral.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.vividBlue.getColor(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  '% 100',
                  style: context.appGeneral.textTheme.titleLarge?.copyWith(
                    color: AppColor.grey.getColor(),
                  ),
                ),
              ),
            ],
          ),
          LinearProgressIndicator(
            value: 0.3,
            backgroundColor: AppColor.bleachedSilk.getColor(),
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColor.vividBlue.getColor(),
            ),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildMealList(BuildContext context) {
    return Column(
      children: [
        _buildMealItem(
          context,
          'Kahvaltı',
          'Önerilen Öğün - 300 / 500 kalori',
          'breakfast',
        ),
        AppSpaces.instance.vertical15,
        _buildMealItem(
          context,
          'Öğle Yemeği',
          'Önerilen Öğün - 800 / 1100 kalori',
          'lunch',
        ),
        AppSpaces.instance.vertical15,
        _buildMealItem(
          context,
          'Atıştırmalıklar',
          'Önerilen Öğün - 400 / 500 kalori',
          'snacks',
        ),
        AppSpaces.instance.vertical15,
        _buildMealItem(
          context,
          'Akşam Yemeği',
          'Önerilen Öğün - 800 / 1100 kalori',
          'dinner',
        ),
      ],
    );
  }

  Widget _buildMealItem(
    BuildContext context,
    String title,
    String subtitle,
    String imageKey,
  ) {
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
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage('assets/images/meals/$imageKey.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AppSpaces.instance.horizontal15,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.appGeneral.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: context.appGeneral.textTheme.bodyMedium?.copyWith(
                    color: AppColor.grey.getColor(),
                  ),
                ),
              ],
            ),
          ),
          CustomElevatedButton(
            onPressed: () {},
            width: 72,
            height: 40,
            elevation: 0,
            backgroundColor: AppColor.noxious.getColor(),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.instance.normalBorderRadius,
            ),
            child: Text(
              '+ Ekle',
              style: context.appGeneral.textTheme.labelLarge?.copyWith(
                color: AppColor.white.getColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
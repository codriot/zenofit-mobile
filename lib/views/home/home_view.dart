import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/page_utils/home_view_mixin.dart';
import 'package:flutter/material.dart';


class HomeView extends StatelessWidget with HomeViewMixin {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.instance.horizontalNormal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(context),
              AppSpaces.instance.vertical20,
              buildNutritionSection(context),
              AppSpaces.instance.vertical20,
              buildWaterIntakeSection(context),
              AppSpaces.instance.vertical20,
              buildDietPlanSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Keşfet'),
          BottomNavigationBarItem(icon: Icon(Icons.add_chart), label: 'Öğünlerim'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
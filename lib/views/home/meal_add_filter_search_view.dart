import 'package:diet_app_mobile/controller/home/meal/meal_add_filter_search_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealAddFilterSearchView extends GetView<MealAddFilterSearchController> {
  const MealAddFilterSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // klavyeyi kapatır
            print("tıklandı");
          },
          child: Column(
            children: [
              _buildHeader(context),
              _buildSearchBar(context),
              AppSpaces.instance.vertical15,
              _buildSectionTitle(context, "Geçmiş"),
              Expanded(
                child: _buildMealList(context),
              ),
            ],
          ),
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
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Center(
              child: Obx(() => Text(
                    controller.selectedMealType.value,
                    style:
                        context.appGeneral.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final double height = Get.height * 0.07;
    return Padding(
      padding: AppPadding.instance.horizontalNormal,
      child: SizedBox(
        height: height,
        child: Obx(
          () => TextField(
            controller: controller.searchController,
            decoration: InputDecoration(
              hintText: 'Yemek ara',
              contentPadding: EdgeInsets.symmetric(
                  vertical: (height - 24) / 2), // 24: yaklaşık yazı yüksekliği
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: AppRadius.instance.normalBorderRadius,
                borderSide: BorderSide.none,
              ),
              suffixIcon: controller.isSearchActive.value
                  ? InkWell(
                      onTap: controller.clearSearch,
                      child: const Icon(Icons.close),
                    )
                  : null,
              filled: true,
              fillColor: AppColor.crystalBell.getColor().withOpacity(0.5),
            ),
            onChanged: controller.onSearchChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: AppPadding.instance.horizontalNormal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Text(
                controller.isSearchActive.value ? 'Aranıyor...' : title,
                style: context.appGeneral.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              )),
          TextButton(
            onPressed: controller.onQuickAddPressed,
            child: Text(
              'Hızlı Ekle',
              style: context.appGeneral.textTheme.titleMedium?.copyWith(
                color: AppColor.vividBlue.getColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealList(BuildContext context) {
    return Obx(() => ListView.builder(
          padding: AppPadding.instance.horizontalNormal,
          itemCount: controller.recentMeals.length,
          itemBuilder: (context, index) {
            final meal = controller.recentMeals[index];
            return _buildMealItem(context, meal);
          },
        ));
  }

  Widget _buildMealItem(BuildContext context, Map<String, dynamic> meal) {
    return Container(
      margin: AppPadding.instance.bottomSmall,
      decoration: BoxDecoration(
        color: AppColor.white.getColor(),
        borderRadius: AppRadius.instance.normalBorderRadius,
        boxShadow: [
          BoxShadow(
            color: AppColor.crystalBell.getColor(),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        
        title: Text(
          meal['title'] as String,
          style: context.appGeneral.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          '${meal['calories']} kal, ${meal['amount']}',
          style: context.appGeneral.textTheme.bodyMedium?.copyWith(
            color: AppColor.grey.getColor(),
          ),
        ),
        trailing: CustomElevatedButton(
          onPressed: () => controller.onAddMealPressed(meal),
          elevation: 0,
          backgroundColor: AppColor.crystalBell.getColor(),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.instance.largeBorderRadius,
          ),
          width: 40,
          height: 40,
          child: Icon(
            Icons.add,
            color: AppColor.vividBlue.getColor(),
            size: 20,
          ),
        ),
      ),
    );
  }
}

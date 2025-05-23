import 'package:diet_app_mobile/controller/home/meal/meal_add_controller.dart';
import 'package:diet_app_mobile/model/home/meal_model.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_duration.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealAddView extends GetView<MealAddController> {
  const MealAddView({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      body: CustomScrollView(
        slivers: [
          _buildPageAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildDateContainer(),
                AppSpaces.instance.vertical15,
                _buildProgressSection(context),
                AppSpaces.instance.vertical25,
                _buildMealList(context),
                AppSpaces.instance.vertical25,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildDateContainer() {
    return Container(
      height: Get.height * 0.07,
      decoration: BoxDecoration(
        color: AppColor.transparent.getColor(),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.days.length,
        itemBuilder: (context, index) {
          final date = controller.days[index];
          return AddMealButton(
              controller: controller, date: date, index: index);
        },
      ),
    );
  }

  SliverAppBar _buildPageAppBar(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'Öğün Ekle',
          style: context.appGeneral.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        background: Container(
          color: AppColor.whiteSolid.getColor(), // Burada arka plan rengini belirleyebilirsiniz
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
    final List<Map<String, String>> meals = [
      {
        'title': 'Kahvaltı',
        'type': 'breakfast',
      },
      {
        'title': 'Öğle Yemeği',
        'type': 'lunch',
      },
      {
        'title': 'Akşam Yemeği',
        'type': 'dinner',
      },
    ];

    return Column(
      children: [
        ...meals.map((meal) => _buildMealItem(
          context,
          meal['title']!,
          'Önerilen Öğün - 800 / 1100 kalori',
          meal['type']!,
        )),
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              AppSpaces.instance.vertical10,
              CustomElevatedButton(
                onPressed: () {
                  NavigatorController.instance.pushToPage(
                    NavigateRoutesItems.addMealDetail,
                    arguments: {'meal': MealModel.fromType(imageKey)},
                  );
                },
                width: Get.width * 0.3,
                elevation: 0,
                backgroundColor: AppColor.noxious.getColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.instance.normalBorderRadius,
                ),
                child: Text(
                  '+ Ekle',
                  style: context.appGeneral.textTheme.titleMedium?.copyWith(
                    color: AppColor.white.getColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: -16,
            top: -20,
            child: Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(AppImageUtility.getImagePath(
                    imageKey,
                    format: ImageFormat.png,
                  )),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddMealButton extends StatelessWidget {
  const AddMealButton({
    super.key,
    required this.controller,
    required this.date,
    required this.index,
  });

  final MealAddController controller;
  final DateTime date;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () => controller.selectDay(index),
        child: Obx(
          () {
            final isSelected = controller.selectedDayIndex.value == index;
            return AnimatedContainer(
              duration: AppDuration.instance.durationFast,
              curve: Curves.easeInOut,
              width: isSelected ? Get.width * 0.36 : Get.height * 0.07,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.vividBlue.getColor()
                    : AppColor.white.getColor(),
                borderRadius: AppRadius.instance.largeBorderRadius,
              ),
              child: Center(
                child: isSelected
                    ? Padding(
                        padding: AppPadding.instance.horizontalNormal,
                        child: Text(
                          'Bugün, ${date.day} ${controller.getMonthName(date.month)}',
                          overflow: TextOverflow.ellipsis,
                          style:
                              context.appGeneral.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.white.getColor(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    : Text(
                        date.day.toString(),
                        style:
                            context.appGeneral.textTheme.titleMedium?.copyWith(
                          color: AppColor.black.getColor(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}

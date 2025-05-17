import 'package:diet_app_mobile/controller/home/water/add_water_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_duration.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddWaterView extends GetView<AddWaterController> {
  const AddWaterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildDateSelector(context),
            Expanded(
              child: SingleChildScrollView(
                padding: AppPadding.instance.allNormal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWaterAmountInput(context),
                    AppSpaces.instance.vertical25,
                    buildWaterIntakeSection(context),
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
            onPressed: () => NavigatorController.instance.pop(),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Su Ekle',
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

  Widget _buildDateSelector(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColor.transparent.getColor(),
        boxShadow: [
          BoxShadow(
            color: AppColor.crystalBell.getColor(),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.days.length,
        itemBuilder: (context, index) {
          final date = controller.days[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Obx(() {
              final isSelected = controller.selectedDayIndex.value == index;
              return InkWell(
                onTap: () => controller.selectDay(index),
                child: AnimatedContainer(
                  duration: AppDuration.instance.durationFast,
                  curve: Curves.easeInOut,
                  width: isSelected ? 140 : 50,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColor.vividBlue.getColor()
                        : AppColor.white.getColor(),
                    borderRadius: AppRadius.instance.largeBorderRadius,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.crystalBell.getColor(),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: isSelected
                        ? Padding(
                            padding: AppPadding.instance.horizontalNormal,
                            child: Text(
                              controller.getFormattedDate(date),
                              overflow: TextOverflow.ellipsis,
                              style: context.appGeneral.textTheme.bodyMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor.white.getColor(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        : Text(
                            date.day.toString(),
                            style: context.appGeneral.textTheme.titleMedium
                                ?.copyWith(
                              color: AppColor.black.getColor(),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget buildWaterIntakeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Alınan Su',
            style: context.appGeneral.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        AppSpaces.instance.vertical10,
        Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Günde 12 bardak su iç',
                    style: context.appGeneral.textTheme.bodyLarge
                        ?.copyWith(color: AppColor.grey.getColor()),
                  ),
                  AppSpaces.instance.vertical10,
                  Obx(() => Row(
                    children: [
                      Text(
                        '${controller.currentWaterAmount.value}L',
                        style:
                            context.appGeneral.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.vaporwaweBlue.getColor(),
                        ),
                      ),
                      Text(
                        ' / ${controller.targetWaterAmount.value}L',
                        style: context.appGeneral.textTheme.titleLarge
                            ?.copyWith(color: AppColor.grey.getColor()),
                      ),
                    ],
                  )),
                  AppSpaces.instance.vertical15,
                  SizedBox(
                    height: 64,
                    width: Get.width - 120,
                    child: Obx(() {
                      if (controller.addedWaterAmounts.isEmpty) {
                        return const SizedBox(); // Boş liste durumunda boş widget döndür
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.addedWaterAmounts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Column(
                              children: [
                                Image.asset(
                                  AppIconUtility.getIconPath(
                                    "water-circle",
                                    format: IconFormat.png,
                                  ),
                                  height: 40,
                                ),
                                Padding(
                                  padding: AppPadding.instance.leftSmall,
                                  child: Text(
                                    '${controller.addedWaterAmounts[index]} ml',
                                    style: context.appGeneral.textTheme.bodyMedium
                                        ?.copyWith(
                                            color: AppColor.black.getColor()),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  )
                ],
              ),
              Padding(
                padding: AppPadding.instance.bottomNormal,
                child: SvgPicture.asset(
                  AppIconUtility.getIconPath(
                    "water-glass",
                    format: IconFormat.svg,
                  ),
                  height: 56,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWaterAmountInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColor.crystalBell.getColor(),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Su Miktarı',
                style: context.appGeneral.textTheme.titleMedium?.copyWith(
                  color: AppColor.grey.getColor(),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller.manualWaterController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  style: context.appGeneral.textTheme.titleMedium?.copyWith(
                    color: AppColor.vividBlue.getColor(),
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: '0 ml',
                    hintStyle: context.appGeneral.textTheme.titleMedium?.copyWith(
                      color: AppColor.vividBlue.getColor(),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: AppColor.black12.getColor(),
          height: 1,
        ),  
      ],
    );
  }
}

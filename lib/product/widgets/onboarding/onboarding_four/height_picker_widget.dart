import 'package:diet_app_mobile/product/controller/height_picker_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:diet_app_mobile/product/widgets/general/general_shadow_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HeightPickerWidget extends StatelessWidget {
  HeightPickerWidget({super.key});

  final HeightPickerController controller = Get.put(HeightPickerController());

  @override
  Widget build(BuildContext context) {
    final double containerHeight = Get.height * 0.45;

    return Padding(
      padding: AppPadding.instance.horizontalMedium,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Seçilen yükseklik metni
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (controller.selectedHeight.value + 4).toStringAsFixed(0),
                  style: context.appGeneral.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    shadows: [generalComponentsShadow()],
                  ),
                ),
                Padding(
                  padding: AppPadding.instance.leftSmall,
                  child: Text(
                    "cm",
                    style: context.appGeneral.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.paintedDesert.getColor(),
                      shadows: [generalComponentsShadow()],
                    ),
                  ),
                ),
              ],
            );
          }),

          // Yükseklik seçici çubuğu
          Padding(
            padding: AppPadding.instance.verticalMedium,
            child: Container(
              height: containerHeight,
              width: 145,
              decoration: BoxDecoration(
                color: AppColor.crystalBell.getColor(),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [generalComponentsShadow()],
              ),
              child: Stack(
                children: [
                  ListView.builder(
                    controller: controller.scrollController,
                    padding: EdgeInsets.zero,
                    itemCount: ((controller.maxHeight - controller.minHeight) /
                                controller.increment)
                            .toInt() +
                        1,
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    itemBuilder: (context, index) {
                      bool isMainHeight = index % 10 == 0;
                      double heightValue =
                          controller.minHeight + index * controller.increment;

                      return SizedBox(
                        height: controller.itemHeight,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            // Çizgiler
                            Positioned(
                              right: isMainHeight ? 24 : 32,
                              child: Container(
                                width: isMainHeight ? 40 : 24,
                                height: 2,
                                color: Colors.black,
                              ),
                            ),
                            // Ana çizgilerde değer gösterimi
                            if (isMainHeight)
                              Positioned(
                                right: 70,
                                child: Padding(
                                  padding: AppPadding.instance.rightSmall,
                                  child: Text(
                                    heightValue.toInt().toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Gösterge oku
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    child: SvgPicture.asset(
                      AppIconUtility.getIconPath(
                        "arrow-right-fill",
                        format: IconFormat.svg,
                      ),
                      height: AppSizes.instance.iconSizeNormal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart'
    show AppPadding;
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:diet_app_mobile/product/controller/weight_picker_controller.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:diet_app_mobile/product/widgets/general/general_shadow_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class WeightPickerWidget extends StatelessWidget {
  WeightPickerWidget({super.key});

  final WeightPickerController controller = Get.put(WeightPickerController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.instance.horizontalMedium,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Kilo Display
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (controller.selectedWeight.value).toStringAsFixed(1), // Kilo değeri 1 ondalık basamağa yuvarlanacak
                  style: context.appGeneral.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      shadows: [generalComponentsShadow()]),
                ),
                Padding(
                  padding: AppPadding.instance.leftSmall,
                  child: Text(
                    "kg",
                    style: context.appGeneral.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.paintedDesert.getColor(),
                        shadows: [generalComponentsShadow()]),
                  ),
                ),
              ],
            );
          }),

          // Kilo Seçici Çubuğu
          Padding(
            padding: AppPadding.instance.verticalMedium,
            child: Container(
              height: 145, // Çubuğun yüksekliği
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.crystalBell.getColor(),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [generalComponentsShadow()],
              ),
              child: Stack(
                children: [
                  ListView.builder(
                    controller: controller
                        .scrollController, // Burada controller'ı kullanıyoruz
                    padding: EdgeInsets.zero,
                    itemCount: ((controller.maxWeight - controller.minWeight) /
                                controller.increment)
                            .toInt() +
                        1,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      bool isMainWeight = index % 5 == 0;
                      int mainWeightIndex = index ~/ 5;
                      double weightValue =
                          controller.minWeight + mainWeightIndex;

                      return SizedBox(
                        width: controller.itemHeight,
                        height: controller
                            .itemHeight, // Kapsayıcı genişliğini küçültüyoruz
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            // Çubuklar
                            Positioned(
                              bottom: isMainWeight
                                  ? 24
                                  : 32, // Çubuğun hizasını aşağıya alıyoruz
                              child: Container(
                                width: 2, // Çubuğun genişliği
                                height: isMainWeight
                                    ? 40
                                    : 24, // Çubuğun yüksekliği
                                color: Colors.black,
                              ),
                            ),
                            // Tıklanabilir alan
                            if (isMainWeight)
                              Positioned(
                                bottom: 70, // Sabit bir konumda yerleştiriyoruz
                                child: CustomElevatedButton(
                                  elevation: 0,
                                  backgroundColor: AppColor.transparent.getColor(),
                                  onPressed: () {
                                    debugPrint('Tapped on $weightValue');
                                    controller
                                        .updateSelectedWeight(weightValue - 0.8);
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: Text(
                                      weightValue.toInt().toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Icon(Icons.arrow_drop_down,
                        size: AppSizes.instance.iconSizeMedium,
                        color: Colors.black),
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

import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/widgets/general/general_page_button.dart';
import 'package:diet_app_mobile/product/widgets/general/general_shadow_components.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_page_circle.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_top_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingThreeView extends StatelessWidget {
  OnboardingThreeView({super.key});
  final GlobalOnboardingController globalOnboardingController =
      Get.find<GlobalOnboardingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingTopComponents(title: "Kilonuz Kaç?"),
            Expanded(
              child: WeightPickerWidget(),
            ),
            GeneralOnboardingPageCircleComponent(),
            Padding(
              padding: AppPadding.instance.horizontalMedium,
              child: GeneralPageButtonWidget(
                onPressed: () {
                  globalOnboardingController.toggleOnboardingPageCount(
                      OnboardingPageCountEnum.onboardingPageThree.index);
                  NavigatorController.instance
                      .pushToPage(NavigateRoutesItems.onboardingThree);
                },
                text: "Next",
                padding: AppPadding.instance.bottomNormal,
                isIconActive: true,
              ),
            ),
            Padding(
              padding: AppPadding.instance.horizontalMedium,
              child: GeneralPageButtonWidget(
                onPressed: () {},
                text: "Skip",
                padding: AppPadding.instance.bottomNormal,
                backgroundColor: AppColor.sweetPatato.getColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeightPickerController extends GetxController {
  var selectedWeight = 75.obs; // Varsayılan kilo
  final double itemHeight = 30.0; // Her bir öğenin yüksekliği
  final double barHeight = 4.0; // Çubukların yüksekliği
  final double maxWeight = 150; // Maksimum kilo
  final double minWeight = 30; // Minimum kilo

  void updateSelectedWeight(int weight) {
    selectedWeight.value = weight;
  }
}
class WeightPickerWidget extends StatelessWidget {
  WeightPickerWidget({Key? key}) : super(key: key);

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
                  controller.selectedWeight.value.toString(),
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
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Container(
              height: 200, // Çubuğun yüksekliği
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.black26,
                      offset: Offset(0, 4))
                ],
              ),
              child: ListView.builder(
                itemCount:
                    (controller.maxWeight - controller.minWeight).toInt() + 1,
                itemExtent: controller.itemHeight,
                scrollDirection: Axis.horizontal, // Sayılar yatay gidecek
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  int weight = controller.minWeight.toInt() + index;
                  bool isSelected = weight == controller.selectedWeight.value;
                  return GestureDetector(
                    onTap: () => controller.updateSelectedWeight(weight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Kilo Değeri
                        Text(
                          weight.toString(),
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: isSelected ? 32 : 24,
                            color: isSelected ? Colors.blue : Colors.black,
                          ),
                        ),
                        // Çubuklar (Dikey)
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Container(
                            width: controller.barHeight, // Çubuğun genişliği
                            height: isSelected
                                ? 100 // Seçilen kilo için daha uzun çubuk
                                : 40, // Diğer çubuklar
                            color: isSelected ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
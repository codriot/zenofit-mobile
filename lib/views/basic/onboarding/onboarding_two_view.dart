import 'package:diet_app_mobile/product/controller/age_picker_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/general_page_button.dart';
import 'package:diet_app_mobile/product/widgets/general/general_shadow_components.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_page_circle.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_top_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/basic/global_onboarding_controller.dart';

class OnboardingTwoView extends StatelessWidget {
  OnboardingTwoView({super.key});
  final GlobalOnboardingController globalOnboardingController =
      Get.find<GlobalOnboardingController>();
  final AgePickerController controller = Get.put(AgePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingTopComponents(title: "Yaşınız Kaç?"),
            Padding(
              padding: AppPadding.instance.verticalLarge,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // ListView (Yaşlar)
                      Container(
                        height: 350,
                        width: 145,
                        decoration: BoxDecoration(
                          color: AppColor.crystalBell.getColor(),
                          borderRadius: AppRadius.instance.largeBorderRadius,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (scrollNotification) {
                            if (scrollNotification
                                is ScrollUpdateNotification) {
                              controller.onScrollUpdate();
                            } else if (scrollNotification
                                is ScrollEndNotification) {
                              controller.onScrollEnd();
                            }
                            return true;
                          },
                          child: ListView.builder(
                            controller: controller.scrollController,
                            itemCount: 100,
                            itemExtent: controller.itemHeight,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Obx(() {
                                final isSelected =
                                    index == controller.selectedAge.value;
                                return Center(
                                  child: Text(
                                    "$index",
                                    style: TextStyle(
                                      fontSize: isSelected ? 24 : 18,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                      ),
                      // Üst Çizgi
                      Positioned(
                        top: 150,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2,
                          color: AppColor.black.getColor(),
                        ),
                      ),
                      // Alt Çizgi
                      Positioned(
                        bottom: 150,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2,
                          color: AppColor.black.getColor(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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

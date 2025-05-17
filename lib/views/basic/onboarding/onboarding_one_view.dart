import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:diet_app_mobile/product/widgets/general/general_page_button.dart';
import 'package:diet_app_mobile/product/widgets/general/general_shadow_components.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_page_circle.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_top_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OnboardingOneView extends StatelessWidget {
  OnboardingOneView({super.key});
  final GlobalOnboardingController globalOnboardingController = Get.find<GlobalOnboardingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OnboardingTopComponents(title: "Cinsiyetiniz Nedir?",),
            _buildPageGenderComponent(
                context: context, icon: "men", text: "Erkek"),
            _buildPageGenderComponent(
                context: context, icon: "woman", text: "kadın"),
            _buildPageGenderComponent(
                context: context, icon: "genderless", text: "Hiçbiri"),
            _buildPageGenderComponent(
                context: context, icon: "close", text: "Belirtmek İstemiyorum"),
            const Spacer(),
            GeneralOnboardingPageCircleComponent(),
            Padding(
              padding: AppPadding.instance.horizontalMedium,
              child: GeneralPageButtonWidget(
                onPressed: () {
                  globalOnboardingController.toggleOnboardingPageCount(OnboardingPageCountEnum.onboardingPageTwo.index);
                  NavigatorController.instance.pushToPage(NavigateRoutesItems.onboardingTwo);
                },
                text: "Next",
                padding: AppPadding.instance.bottomNormal,
                isIconActive: true,
              ),
            ),
            Padding(
              padding: AppPadding.instance.horizontalMedium,
              child: GeneralPageButtonWidget(
                onPressed: () {
                  globalOnboardingController.toggleOnboardingPageCount(OnboardingPageCountEnum.onboardingPageSix.index);
                  NavigatorController.instance.pushToPage(NavigateRoutesItems.main);
                },
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

  Container _buildPageGenderComponent(
      {required BuildContext context,
      required String text,
      required String icon}) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
          borderRadius: AppRadius.instance.mediumBorderRadius,
          color: AppColor.crystalBell.getColor(),
          boxShadow: [
            generalComponentsShadow(),
          ]),
      padding: AppPadding.instance.leftMedium,
      width: Get.width * 0.72,
      height: 72,
      child: Row(
        children: [
          SvgPicture.asset(
            AppIconUtility.getIconPath(icon, format: IconFormat.svg),
            height: AppSizes.instance.iconSizeNormal,
          ),
          Padding(
            padding: AppPadding.instance.leftSmall,
            child: Text(
              text,
              style: context.appGeneral.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}


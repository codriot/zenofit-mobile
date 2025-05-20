import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/controller/basic/onboarding/onboarding_one_controller.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OnboardingOneView extends GetView<OnboardingOneController> {
  OnboardingOneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _onboardingTopComponentPage(context),
            _buildPageGenderComponent(
              context: context,
              icon: "men",
              text: "Erkek",
              gender: GenderType.male,
              onTap: () => controller.selectGender(GenderType.male),
            ),
            _buildPageGenderComponent(
                onTap: () => controller.selectedGender(GenderType.female),
                gender: GenderType.female,
                context: context,
                icon: "woman",
                text: "kadın"),
            _buildPageGenderComponent(
                onTap: () => controller.selectedGender(GenderType.none),
                gender: GenderType.none,
                context: context,
                icon: "genderless",
                text: "Hiçbiri"),
            _buildPageGenderComponent(
                gender: GenderType.preferNotToSay,
                onTap: () =>
                    controller.selectedGender(GenderType.preferNotToSay),
                context: context,
                icon: "close",
                text: "Belirtmek İstemiyorum"),
            const Spacer(),
            GeneralOnboardingPageCircleComponent(),
            Padding(
              padding: AppPadding.instance.horizontalMedium,
              child: GeneralPageButtonWidget(
                onPressed: controller.pushToOtherPage,
                text: "Next",
                padding: AppPadding.instance.bottomNormal,
                isIconActive: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageGenderComponent(
      {required BuildContext context,
      required String text,
      required String icon,
      required void Function() onTap,
      required GenderType gender}) {
    return Obx(
      () {
        final isSelected = controller.isGenderSelected(gender);
        return Padding(
          padding: EdgeInsets.only(top: Get.height * 0.035),
          child: InkWell(
            borderRadius: AppRadius.instance.mediumBorderRadius,
            onTap: () => controller.selectedGender(gender),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: AppRadius.instance.mediumBorderRadius,
                  color: isSelected
                      ? AppColor.vividBlue.getColor()
                      : AppColor.crystalBell.getColor(),
                  boxShadow: [
                    generalComponentsShadow(),
                  ]),
              padding: AppPadding.instance.leftMedium,
              width: Get.width * 0.72,
              height: Get.height * 0.1,
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIconUtility.getIconPath(icon, format: IconFormat.svg),
                    height: AppSizes.instance.iconSizeNormal,
                    color: isSelected
                        ? AppColor.white.getColor()
                        : AppColor.black.getColor(),
                  ),
                  Padding(
                    padding: AppPadding.instance.leftSmall,
                    child: Text(
                      text,
                      style: context.appGeneral.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: isSelected
                              ? AppColor.white.getColor()
                              : AppColor.black.getColor()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _onboardingTopComponentPage(BuildContext context){
    return Column(
      children: [
        Stack(
          alignment: Alignment.center, // Text'i ortalamak için kullanılır
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: Text(
                "Cinsiyetiniz Nedir?",
                style: context.appGeneral.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Text ortalama
              ),
            ),
          ],
        ),
        Padding(
          padding: AppPadding.instance.horizontalMedium,
          child: Text(
            "Size daha iyi bir seçenek sunabilmemiz için bilgileri boş bırakmayınız.",
            textAlign: TextAlign.center,
            style: context.appGeneral.textTheme.bodyMedium?.copyWith(),
          ),
        ),
      ],
    );
  }
}

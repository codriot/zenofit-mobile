import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OnboardingTopComponents extends StatelessWidget {
  OnboardingTopComponents({
    super.key,
    required this.title,
  });
  final String title;
  final GlobalOnboardingController globalOnboardingController =
      Get.put(GlobalOnboardingController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center, // Text'i ortalamak için kullanılır
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomElevatedButton(
                  backgroundColor: AppColor.transparent.getColor(),
                  elevation: 0,
                  height: 48,
                  width: 48,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  child: SvgPicture.asset(
                    AppIconUtility.getIconPath("arrow-left",
                        format: IconFormat.svg),
                    height: AppSizes.instance.iconSizeNormal,
                  ),
                  onPressed: () {
                    globalOnboardingController.togglePreviousOnboardingPage();
                    NavigatorController.instance.pop();
                  },
                ),
              ],
            ),
            Text(
              title,
              style: context.appGeneral.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Text ortalama
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

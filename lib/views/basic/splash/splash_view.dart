import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/chrome_status_bar_service.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/widgets/general/general_page_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    ChromeStatusBarService.setDarkStatusBar();
    return Scaffold(
      floatingActionButton: Padding(
        padding: AppPadding.instance.horizontalMedium,
        child: GeneralPageButtonWidget(onPressed: () {
          NavigatorController.instance.pushToPage(NavigateRoutesItems.login);
        }, text: "Başla"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: AppPadding.instance.horizontalMedium,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: Get.height * 0.02),
              child: Image.asset(AppImageUtility.getImagePath("bitirme-logo")),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.12),
              child: Text("İstediğin fit ve sağlıklı yaşama hazır mısın?",
                  textAlign: TextAlign.center,
                  style: context.appGeneral.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.02),
              child: Text(
                textAlign: TextAlign.center,
                "Yapay zeka ile ücretsiz bir şekilde bilgi alabilir ve kendinize özel bir diyet oluşturabilirsiniz.",
                style: context.appGeneral.textTheme.bodyLarge
                    ?.copyWith(color: AppColor.shadowedSteel.getColor()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

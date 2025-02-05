import 'package:diet_app_mobile/API/services/auth/auth_service.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:diet_app_mobile/product/utils/app_utils/dynamic_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_text_field.dart';
import 'package:diet_app_mobile/product/widgets/general/general_page_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _buildAppLogo(),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.lightGreenGlint.getColor(),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(64),
                  topRight: Radius.circular(64),
                )),
            child: Padding(
              padding: EdgeInsets.only(top: Get.height * 0.03),
              child: Padding(
                padding: AppPadding.instance.horizontalMedium,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildMakeLoginText(context),
                    _buildDoYouHaveAcountEither(context),
                    _buildMailText(context),
                    _buildPageTextField(context,
                        hintText: "example@example.com", icon: "mail"),
                    _buildPasswordText(context),
                    _buildPageTextField(context,
                        hintText: "example", icon: "password"),
                    _buildForgetThePasswordText(context),
                    _buildOrText(context),
                    _buildLoginWithGooglOrApple(),
                    GeneralPageButtonWidget(
                      onPressed: () {
                        NavigatorController.instance.pushToPage(NavigateRoutesItems.onboardingOne);
                      },
                      text: "Giriş Yap",
                      padding: EdgeInsets.only(top: Get.height * 0.03),
                    ),
                    _buildFingerPrintButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Padding _buildAppLogo() {
    return Padding(
        padding: EdgeInsets.only(top: Get.height * 0.03),
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            AppImageUtility.getImagePath("bitirme-logo"),
            width: 120,
            height: 120,
          ),
        ),
      );
  }

  Center _buildFingerPrintButton() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: Get.height * 0.02),
        child: InkWell(
          child: SvgPicture.asset(
            AppIconUtility.getIconPath("finger", format: IconFormat.svg),
            width: AppSizes.instance.iconSizeXLarge,
            height: AppSizes.instance.iconSizeXLarge,
          ),
        ),
      ),
    );
  }

  Row _buildLoginWithGooglOrApple() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.white.getColor(),
          ),
          height: Get.height * 0.09,
          width: Get.height * 0.09,
          child: Center(
            child: SvgPicture.asset(
              AppIconUtility.getIconPath("apple", format: IconFormat.svg),
              height: AppSizes.instance.iconSizeLarge,
              width: AppSizes.instance.iconSizeLarge,
            ),
          ),
        ),
        Padding(
          padding: AppPadding.instance.leftNormal,
          child: GestureDetector(
                       onTap: () async {
              // Google Sign-In işlemini başlat ve tamamlanmasını bekle
           await AuthService().signInWithGoogle();
            if (AuthService().currentUser != null) {
              // Google Sign-In işlemi tamamlandıktan sonra sayfayı değiştir
              NavigatorController.instance.pushToPage(NavigateRoutesItems.onboardingOne);
            }
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white.getColor(),
              ),
              height: Get.height * 0.09,
              width: Get.height * 0.09,
              child: Center(
                child: SvgPicture.asset(
                  AppIconUtility.getIconPath("google", format: IconFormat.svg),
                  height: AppSizes.instance.iconSizeLarge,
                  width: AppSizes.instance.iconSizeLarge,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Center _buildOrText(BuildContext context) {
    return Center(
      child: Text(
        "veya",
        style: context.appGeneral.textTheme.bodyMedium
            ?.copyWith(color: AppColor.shadowedSteel.getColor()),
      ),
    );
  }

  TextButton _buildForgetThePasswordText(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Text(
          "Şifreni mi unuttun?",
          style: context.appGeneral.textTheme.bodyMedium
              ?.copyWith(color: AppColor.shadowedSteel.getColor()),
        ));
  }

  Padding _buildPasswordText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.03),
      child: Text(
        "Şifre",
        style: context.appGeneral.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding _buildMailText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.03),
      child: Text(
        "E-Posta",
        style: context.appGeneral.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Row _buildDoYouHaveAcountEither(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hesabınız yok mu?",
          style: context.appGeneral.textTheme.bodyLarge
              ?.copyWith(color: AppColor.shadowedSteel.getColor()),
        ),
        Padding(
          padding: AppPadding.instance.leftSmall,
          child: InkWell(
            child: Text(
              "Hesap Oluştur",
              style: context.appGeneral.textTheme.bodyLarge
                  ?.copyWith(color: AppColor.noxious.getColor()),
            ),
            onTap: () {
              NavigatorController.instance
                  .pushToPage(NavigateRoutesItems.register);
            },
          ),
        ),
      ],
    );
  }

  Center _buildMakeLoginText(BuildContext context) {
    return Center(
      child: Text(
        "Giriş Yap",
        style: context.appGeneral.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColor.noxious.getColor(),
        ),
      ),
    );
  }

  Container _buildPageTextField(
    BuildContext context, {
    required String icon,
    required String hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white.getColor(),
        borderRadius: context.border.normalBorderRadius,
      ),
      child: Row(
        children: [
          Padding(
            padding: AppPadding.instance.leftMedium,
            child: SvgPicture.asset(
              AppIconUtility.getIconPath(icon, format: IconFormat.svg),
              width: AppSizes.instance.iconSizeLow,
              height: AppSizes.instance.iconSizeLow,
            ),
          ),
          Expanded(
            child: CustomTextField(
                padding: EdgeInsets.zero,
                hintText: hintText,
                controller: TextEditingController()),
          ),
        ],
      ),
    );
  }
}

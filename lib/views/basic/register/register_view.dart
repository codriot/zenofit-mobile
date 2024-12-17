import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/dynamic_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_text_field.dart';
import 'package:diet_app_mobile/product/widgets/general_page_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: Get.height * 0.03),
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              AppImageUtility.getImagePath("bitirme-logo"),
              width: 120,
              height: 120,
            ),
          ),
        ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMakeRegisterText(context),
                    _buildDoYouHaveAcountEither(context),
                    _buildInputText(context,text: "Ad, Soyad"),
                    _buildPageTextField(context,
                        hintText: "example", icon: "user"),
                    _buildInputText(context,text: "E-Posta"),
                    _buildPageTextField(context,
                        hintText: "example@gmail.com", icon: "password"),
                    _buildInputText(context,text: "Şifre"),
                    _buildPageTextField(context,
                        hintText: "example", icon: "mail"),
                    _buildInputText(context,text: "Şifre Yeniden"),
                    _buildPageTextField(context,
                        hintText: "example", icon: "password"),
                    GeneralPageButtonWidget(
                      onPressed: () {},
                      text: "Giriş Yap",
                      padding: EdgeInsets.only(top: Get.height * 0.02),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Padding _buildInputText(BuildContext context,{required String text}) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.03),
      child: Text(
        text,
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
          "Zaten bir hesabın var mı?",
          style: context.appGeneral.textTheme.bodyMedium
              ?.copyWith(color: AppColor.shadowedSteel.getColor()),
        ),
        Padding(
          padding: AppPadding.instance.leftSmall,
          child: InkWell(
            child: Text(
              "Giriş Yap",
              style: context.appGeneral.textTheme.bodyMedium
                  ?.copyWith(color: AppColor.noxious.getColor()),
            ),
            onTap: () {
              NavigatorController.instance.pushToPage(NavigateRoutesItems.login);
            },
          ),
        ),
      ],
    );
  }

  Center _buildMakeRegisterText(BuildContext context) {
    return Center(
      child: Text(
        "Kayıt Ol",
        style: context.appGeneral.textTheme.headlineSmall?.copyWith(
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
              width: 24,
              height: 24,
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

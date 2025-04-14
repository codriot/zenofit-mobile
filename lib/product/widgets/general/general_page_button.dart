import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:diet_app_mobile/product/utils/app_utils/dynamic_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GeneralPageButtonWidget extends StatelessWidget {
  const GeneralPageButtonWidget({
    super.key,
    required this.onPressed,
    this.padding,
    required this.text,
    this.isIconActive, this.backgroundColor, this.height,
  });

  final void Function() onPressed;
  final EdgeInsets? padding;
  final String text;
  final bool? isIconActive;
  final Color? backgroundColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(top: Get.height * 0.08),
      child: CustomElevatedButton(
        elevation: 0,
        backgroundColor: backgroundColor ?? AppColor.noxious.getColor(),
        height: height ?? 56,
        width: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: context.border.normalBorderRadius,
        ),
        onPressed: onPressed,
        child: Stack(
          children: [
            SizedBox(
              width: Get.width,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: context.appGeneral.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.white.getColor(),
                ),
              ),
            ),
            // İkonu sağ tarafa alıyoruz.
            if (isIconActive ?? false)
              Positioned(
                right: 16, // Sağ kenardan mesafe
                child: SvgPicture.asset(
                  AppIconUtility.getIconPath("arrow-right",
                      format: IconFormat.svg),
                  height: AppSizes.instance.iconSizeNormal,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/dynamic_utils/app_radius.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralPageButtonWidget extends StatelessWidget {
  const GeneralPageButtonWidget({
    super.key,
    required this.onPressed,
    this.padding,
    required this.text,
  });

  final void Function() onPressed;
  final EdgeInsets? padding;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(top: Get.height * 0.08),
      child: CustomElevatedButton(
        elevation: 0,
        backgroundColor: AppColor.noxious.getColor(),
        height: 56,
        width: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: context.border.normalBorderRadius,
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: context.appGeneral.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColor.white.getColor()),
          ),
        ),
      ),
    );
  }
}

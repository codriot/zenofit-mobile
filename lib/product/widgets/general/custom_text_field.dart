import 'package:diet_app_mobile/product/controller/custom_text_field_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';


class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onSubmit;
  final bool showSearchIcon;
  final EdgeInsets? padding;
  final double height; // Yükseklik parametresi

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.onSaved,
    this.onSubmit,
    this.showSearchIcon = false,
    this.padding,
    this.height = 50, // Varsayılan yükseklik
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding ?? EdgeInsets.only(top: 10.0),
      height: height, // Yükseklik ayarı
      decoration: BoxDecoration(
        color: Colors.white, // Arka plan rengi
        borderRadius: BorderRadius.circular(16), // Kenar yuvarlama
        boxShadow: [
          BoxShadow(
            color: AppColor.crystalBell.getColor(),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Gölge konumu
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          prefixIcon: showSearchIcon
              ? Padding(
                  padding: AppPadding.instance.allSmall,
                  child: SvgPicture.asset(
                    'assets/icons/search.svg', // İkon dosya yolu
                    width: 20,
                    color: AppColor.grey.getColor(),
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                )
              : null,
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10, // İçerik üst ve alt boşluğu
            horizontal: 20, // İçerik sağ ve sol boşluğu
          ),
          hintStyle: const TextStyle(color: Colors.grey), // Hint metin rengi
        ),
        validator: validator,
        onSaved: onSaved,
        onFieldSubmitted: onSubmit,
      ),
    );
  }
}

class CustomTextFieldForPassword extends StatelessWidget {
  const CustomTextFieldForPassword({
    super.key,
    required this.hintText,
    required this.validator,
    this.onSaved,
    required this.controller,
  });

  final String hintText;
  final String? Function(String?) validator;
  final void Function(String?)? onSaved;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomTextFieldController>(
      init: CustomTextFieldController(),
      global: false,
      builder: (customController) {
        return Container(
          margin: context.padding.onlyTopLow,
          decoration: BoxDecoration(
            color: AppColor.scaffoldBackgorundColor.getColor(),
            borderRadius: context.border.normalBorderRadius,
          ),
          child: Obx(() => TextFormField(
                controller: controller,
                cursorColor: Colors.black,
                obscureText: customController.isObscure.value,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: context.general.textTheme.labelLarge
                      ?.copyWith(color: AppColor.grey.getColor()),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.02,
                    horizontal: Get.height * 0.02,
                  ),
                  errorStyle: const TextStyle(height: 0),
                  suffixIcon: IconButton(
                    icon: Icon(
                        customController.isObscure.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: customController.isObscure.value
                            ? AppColor.black.getColor()
                            : AppColor.grey.getColor()),
                    onPressed: customController.toggleObscure,
                  ),
                ),
                maxLines: 1,
                validator: validator,
                onSaved: onSaved,
              )),
        );
      },
    );
  }
}


import 'package:diet_app_mobile/product/controller/custom_text_field_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.validator,
    this.onSaved,
    required this.controller,
    this.isPhoneNumber = false,
    this.onSubmit,
    this.color,
    this.focusNode,
    this.onTap, this.padding,
  });

  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onSubmit;
  final TextEditingController controller;
  final bool? isPhoneNumber;
  final Color? color;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding ?? context.padding.onlyTopLow,
      decoration: BoxDecoration(
        color: color ?? AppColor.scaffoldBackgorundColor.getColor(),
        borderRadius: context.border.normalBorderRadius,
      ),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02,
            horizontal: Get.height * 0.03,
          ),
          hintStyle: context.general.textTheme.labelLarge
              ?.copyWith(color: AppColor.grey.getColor()),
          errorStyle: const TextStyle(height: 0),
          counterText: '',
          counterStyle: const TextStyle(height: 0),
        ),
        maxLength: isPhoneNumber ?? false ? 10 : null,
        keyboardType: isPhoneNumber ?? false
            ? TextInputType.phone
            : TextInputType.emailAddress,
        maxLines: 1,
        validator: validator,
        onSaved: onSaved,
        onFieldSubmitted: onSubmit, // Bu kısım submit işlemi için eklenmiştir
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
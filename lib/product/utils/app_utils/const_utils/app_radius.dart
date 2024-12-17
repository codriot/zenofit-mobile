import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:flutter/material.dart' show BorderRadius;

class AppRadius {
  static AppRadius? _instance;
  static AppRadius get instance => _instance ?? AppRadius();

  double get _valueSmall => AppSizes.instance.smallValue;
  double get _valueNormal => AppSizes.instance.normalValue;
  double get _valueMedium => AppSizes.instance.mediumValue;
  double get _valueLarge => AppSizes.instance.largeValue;

  BorderRadius get smallBorderRadius => BorderRadius.circular(_valueSmall);
  BorderRadius get normalBorderRadius => BorderRadius.circular(_valueNormal);
  BorderRadius get halfBorderRadius => BorderRadius.circular(16);
  BorderRadius get mediumBorderRadius => BorderRadius.circular(_valueMedium);
  BorderRadius get largeBorderRadius => BorderRadius.circular(_valueLarge);
}

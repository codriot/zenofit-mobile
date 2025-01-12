import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:flutter/material.dart' show EdgeInsets;

class AppPadding {

  static AppPadding? _instance;
  static AppPadding get instance => _instance ?? AppPadding();

  double get _valueSmall => AppSizes.instance.smallValue;
  double get _valueNormal => AppSizes.instance.normalValue;
  double get _valueMedium => AppSizes.instance.mediumValue;
  double get _valueLarge => AppSizes.instance.largeValue;

  EdgeInsets get kZeroPadding => EdgeInsets.zero;
  
  EdgeInsets get allSmall => EdgeInsets.all(_valueSmall);
  EdgeInsets get allNormal => EdgeInsets.all(_valueNormal);
  EdgeInsets get allMedium => EdgeInsets.all(_valueMedium);
  EdgeInsets get allLarge => EdgeInsets.all(_valueLarge);

  EdgeInsets get topSmall => EdgeInsets.only(top: _valueSmall);
  EdgeInsets get topNormal => EdgeInsets.only(top: _valueNormal);
  EdgeInsets get topMedium => EdgeInsets.only(top: _valueMedium);
  EdgeInsets get topLarge => EdgeInsets.only(top: _valueLarge);

  EdgeInsets get rightSmall => EdgeInsets.only(right: _valueSmall);
  EdgeInsets get rightNormal => EdgeInsets.only(right: _valueNormal);
  EdgeInsets get rightMedium => EdgeInsets.only(right: _valueMedium);
  EdgeInsets get rightLarge => EdgeInsets.only(right: _valueLarge);

  EdgeInsets get bottomSmall => EdgeInsets.only(bottom: _valueSmall);
  EdgeInsets get bottomNormal => EdgeInsets.only(bottom: _valueNormal);
  EdgeInsets get bottomMedium => EdgeInsets.only(bottom: _valueMedium);
  EdgeInsets get bottomLarge => EdgeInsets.only(bottom: _valueLarge);

  EdgeInsets get leftSmall => EdgeInsets.only(left: _valueSmall);
  EdgeInsets get leftNormal => EdgeInsets.only(left: _valueNormal);
  EdgeInsets get leftMedium => EdgeInsets.only(left: _valueMedium);
  EdgeInsets get leftLarge => EdgeInsets.only(left: _valueLarge);

  EdgeInsets get horizontalSmall =>
      EdgeInsets.symmetric(horizontal: _valueSmall);
  EdgeInsets get horizontalMedium =>
      EdgeInsets.symmetric(horizontal: _valueMedium);
  EdgeInsets get horizontalLarge =>
      EdgeInsets.symmetric(horizontal: _valueLarge);
  EdgeInsets get horizontalNormal =>
      EdgeInsets.symmetric(horizontal: _valueNormal);

  EdgeInsets get verticalSmall =>
      EdgeInsets.symmetric(vertical: _valueSmall);
  EdgeInsets get verticalNormal =>
      EdgeInsets.symmetric(vertical: _valueNormal);
  EdgeInsets get verticalMedium =>
      EdgeInsets.symmetric(vertical: _valueMedium);
  EdgeInsets get verticalLarge =>
      EdgeInsets.symmetric(vertical: _valueLarge);
}

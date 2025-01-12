import 'package:diet_app_mobile/product/utils/app_utils/dynamic_utils/app_size.dart';
import 'package:flutter/material.dart';

class _ContextPaddingExtension {
  _ContextPaddingExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  double get _valueSmall => _context.sized.smallValue; //5
  double get _valueNormal => _context.sized.normalValue; //10
  double get _valueMedium => _context.sized.mediumValue; //20
  double get _valueLittleLarge => _context.sized.littleLargeValue;
  double get _valueLarge => _context.sized.largeValue;

  EdgeInsets dynamicAll(double value) =>
      EdgeInsets.all(_context.sized.height * value);

  EdgeInsets dynamicSymmetric({double? vertical, double? horizontal}) =>
      EdgeInsets.symmetric(
          vertical: _context.sized.height * (vertical ?? 0.0),
          horizontal: _context.sized.height * (horizontal ?? 0.0));

  EdgeInsets dynamicOnly(
          {double? top, double? left, double? right, double? bottom}) =>
      EdgeInsets.only(
        top: _context.sized.height * (top ?? 0.0),
        bottom: _context.sized.height * (bottom ?? 0.0),
        right: _context.sized.height * (right ?? 0.0),
        left: _context.sized.height * (left ?? 0.0),
      );

  EdgeInsets get kZeroPadding => EdgeInsets.zero;

  EdgeInsets get allNormal => EdgeInsets.all(_valueNormal);
  EdgeInsets get allsmall => EdgeInsets.all(_valueSmall);
  EdgeInsets get allMedium => EdgeInsets.all(_valueMedium);
  EdgeInsets get allLittleLarge => EdgeInsets.all(_valueLittleLarge);
  EdgeInsets get allLarge => EdgeInsets.all(_valueLarge);


  EdgeInsets get topOnlySmall => EdgeInsets.only(top: _valueSmall);
  EdgeInsets get topOnlyNormal => EdgeInsets.only(top: _valueNormal);
  EdgeInsets get topOnlyMedium => EdgeInsets.only(top: _valueMedium);
  EdgeInsets get topOnlylittleLarge => EdgeInsets.only(top: _valueLittleLarge);
  EdgeInsets get topOnlyLarge => EdgeInsets.only(top: _valueLarge);

  EdgeInsets get rightOnlySmall => EdgeInsets.only(right: _valueSmall);
  EdgeInsets get rightOnlyNormal => EdgeInsets.only(right: _valueNormal);
  EdgeInsets get rightOnlyMedium => EdgeInsets.only(right: _valueMedium);
  EdgeInsets get rightOnlylittleLarge => EdgeInsets.only(right: _valueLittleLarge);
  EdgeInsets get rightOnlyLarge => EdgeInsets.only(right: _valueLarge);

  EdgeInsets get leftOnlySmall => EdgeInsets.only(left: _valueSmall);
  EdgeInsets get leftOnlyNormal => EdgeInsets.only(left: _valueNormal);
  EdgeInsets get leftOnlyMedium => EdgeInsets.only(left: _valueMedium);
  EdgeInsets get leftOnlylittleLarge => EdgeInsets.only(left: _valueLittleLarge);
  EdgeInsets get leftOnlyLarge => EdgeInsets.only(left: _valueLarge);

  EdgeInsets get bottomOnlySmall => EdgeInsets.only(bottom: _valueSmall);
  EdgeInsets get bottomOnlyNormal => EdgeInsets.only(bottom: _valueNormal);
  EdgeInsets get bottomOnlyMedium => EdgeInsets.only(bottom: _valueMedium);
  EdgeInsets get bottomOnlylittleLarge => EdgeInsets.only(bottom: _valueLittleLarge);
  EdgeInsets get bottomOnlyLarge => EdgeInsets.only(bottom: _valueLarge);

  EdgeInsets get smallSymmetricHorizontal =>
      EdgeInsets.symmetric(horizontal: _valueSmall);
  EdgeInsets get normalSymmetricHorizontal =>
      EdgeInsets.symmetric(horizontal: _valueNormal);
  EdgeInsets get mediumSymmetricHorizontal =>
      EdgeInsets.symmetric(horizontal: _valueMedium);
  EdgeInsets get littleLargeSymmetricHorizontal =>
      EdgeInsets.symmetric(horizontal: _valueLittleLarge);
  EdgeInsets get largeSymmetricHorizontal =>
      EdgeInsets.symmetric(horizontal: _valueLarge);

  EdgeInsets get smallSymmetricVertical =>
      EdgeInsets.symmetric(vertical: _valueSmall);
  EdgeInsets get normalSymmetricVertical =>
      EdgeInsets.symmetric(vertical: _valueNormal);
  EdgeInsets get mediumSymmetricVertical =>
      EdgeInsets.symmetric(vertical: _valueMedium);
  EdgeInsets get littleLargeSymmetricVertical =>
      EdgeInsets.symmetric(vertical: _valueLittleLarge);
  EdgeInsets get largeSymmetricVertical =>
      EdgeInsets.symmetric(vertical: _valueLarge);
}

extension ContextPaddingExtension on BuildContext {
  _ContextPaddingExtension get padding => _ContextPaddingExtension(this);
}

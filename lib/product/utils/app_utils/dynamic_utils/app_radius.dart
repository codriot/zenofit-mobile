import 'package:diet_app_mobile/product/utils/app_utils/dynamic_utils/app_size.dart';
import 'package:flutter/cupertino.dart';

class _ContextBorderRadiusExtension {
  _ContextBorderRadiusExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  double get smallValue => _context.sized.smallValue;
  double get normalValue => _context.sized.normalValue;
  double get normalMediumValue => _context.sized.normalMediumValue;
  double get mediumValue => _context.sized.mediumValue;
  double get littleLargeValue => _context.sized.littleLargeValue;
  double get largeValue => _context.sized.largeValue;

  BorderRadius get smallBorderRadius => BorderRadius.circular(smallValue);
  BorderRadius get normalBorderRadius => BorderRadius.circular(normalMediumValue);
  BorderRadius get normalMediumBorderRadius => BorderRadius.circular(mediumValue);
  BorderRadius get mediumBorderRadius => BorderRadius.circular(mediumValue);
  BorderRadius get littleLargeBorderRadius => BorderRadius.circular(littleLargeValue);
  BorderRadius get largeBorderRadius => BorderRadius.circular(largeValue);
}

extension ContextBorderRadiusExtension on BuildContext {
  _ContextBorderRadiusExtension get border =>
      _ContextBorderRadiusExtension(this);
}

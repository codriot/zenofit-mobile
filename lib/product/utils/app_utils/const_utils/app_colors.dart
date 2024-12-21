import 'package:flutter/material.dart' show Color,Colors;

enum AppColor {
  white,
  black,
  green,
  blue,
  red,
  yellow,
  grey,
  black12,
  white10,
  transparent,
  scaffoldBackgorundColor,
  shadowedSteel,
  noxious,
  lightGreenGlint,
  crystalBell,
  sweetPatato,
  vividBlue,
}

extension AppColorExtension on AppColor {
  Color getColor() {
    switch (this) {
      case AppColor.white:
        return const Color(0xFFFFFFFF);
      case AppColor.black:
        return const Color(0xFF000000);
      case AppColor.green:
        return const Color(0xFF00FF00);
      case AppColor.red:
        return const Color(0xFFFF0000);
      case AppColor.grey:
        return const Color(0xFF808080);
      case AppColor.black12:
        return const Color(0xFF000000).withOpacity(0.12);
      case AppColor.white10:
        return const Color(0xFFFFFFFF).withOpacity(0.10);
      case AppColor.transparent:
        return Colors.transparent;
      case AppColor.scaffoldBackgorundColor:
        return const Color(0xFFFFFFFF);
      case AppColor.yellow:
        return const Color(0xffFFFF00);
      case AppColor.blue:
        return const Color(0xff0000FF);
      case AppColor.shadowedSteel:
        return const Color(0xff4A4A4A);
      case AppColor.noxious:
        return const Color(0xff8CA104);
      case AppColor.lightGreenGlint:
        return const Color(0xffE1F7D1);
      case AppColor.crystalBell:
        return const Color(0xffF0EFEF);
      case AppColor.sweetPatato:
        return const Color(0XFFD67D3E);
      case AppColor.vividBlue:
        return const Color(0xff1525FF);
    }
  }
}

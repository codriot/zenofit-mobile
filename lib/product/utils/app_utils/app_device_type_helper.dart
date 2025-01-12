

import 'package:flutter/material.dart';

class AppDeviceTypeHelper{
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.shortestSide >= 600;
  static bool isPhone(BuildContext context) => !isTablet(context);
}
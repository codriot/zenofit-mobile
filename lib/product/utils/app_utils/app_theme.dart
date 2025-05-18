import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

class AppTheme {
  late ThemeData theme;
  final String poppins = "poppins";

  AppTheme(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    theme = ThemeData(
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        toolbarHeight: 76,
        backgroundColor: Colors.transparent, // Ya da istediğiniz renk
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // StatusBar rengini şeffaf yap
          statusBarIconBrightness: Brightness.dark, // İkonları koyu yap
          statusBarBrightness:
              Brightness.light, // (Android için) Status bar'ı açık yap
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: mediaQuery.size.width * 0.11,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        displayMedium: TextStyle(
            fontSize: mediaQuery.size.width * 0.1,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        displaySmall: TextStyle(
            fontSize: mediaQuery.size.width * 0.06,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        headlineLarge: TextStyle(
            fontSize: mediaQuery.size.width * 0.08,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        headlineMedium: TextStyle(
            fontSize: mediaQuery.size.width * 0.06,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        headlineSmall: TextStyle(
            fontSize: mediaQuery.size.width * 0.04,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        titleLarge: TextStyle(
            fontSize: mediaQuery.size.width * 0.05,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        titleMedium: TextStyle(
            fontSize: mediaQuery.size.width * 0.045,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        titleSmall: TextStyle(
            fontSize: mediaQuery.size.width * 0.035,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        bodyLarge: TextStyle(
            fontSize: mediaQuery.size.width * 0.04,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        bodyMedium: TextStyle(
            fontSize: mediaQuery.size.width * 0.032,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        bodySmall: TextStyle(
            fontSize: mediaQuery.size.width * 0.025,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        labelLarge: TextStyle(
            fontSize: mediaQuery.size.width * 0.03,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        labelMedium: TextStyle(
            fontSize: mediaQuery.size.width * 0.02,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
        labelSmall: TextStyle(
            fontSize: mediaQuery.size.width * 0.01,
            color: AppColor.black.getColor()
            // fontFamily: poppins,
            ),
      ),
      scaffoldBackgroundColor: AppColor.white.getColor(),
    );
  }
}

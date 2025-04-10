import 'package:flutter/material.dart' show Colors;
import 'package:flutter/services.dart';

class ChromeStatusBarService {
  /// Koyu ikonlu (açık zemin için) status bar
  static void setDarkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: SystemUiOverlayStyle.dark.statusBarColor, // varsa özelleştir
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light, // iOS için
      ),
    );
  }

  /// Açık ikonlu (koyu zemin için) status bar
  static void setLightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: SystemUiOverlayStyle.light.statusBarColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  /// Tam şeffaf status bar (isteğe bağlı)
  static void setTransparentStatusBar({Brightness iconBrightness = Brightness.dark}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Şeffaf
        statusBarIconBrightness: iconBrightness,
        statusBarBrightness:
            iconBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
      ),
    );
  }
}

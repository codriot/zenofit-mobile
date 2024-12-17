class AppSizes {
  static AppSizes? _instance;
  static AppSizes get instance => _instance ?? AppSizes();

  double get kZero => 0;
  double get smallValue => 8;
  double get normalValue => 12;
  double get mediumValue => 20;
  double get largeValue => 30;
  double get xLargeValue => 40;
  double get xxLargeValue => 60;
  double get floatActionButtonSize => 60;
  double get middleButtonSize => 50;

  double get iconSizeLow => 30;
  double get iconSizeNormal => 35;
  double get iconSizeMedium => 40;
  double get iconSizeLarge => 45;
  double get iconSizeXLarge => 50;

}

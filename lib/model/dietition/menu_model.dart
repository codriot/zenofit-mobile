class MenuModel {
  final String iconUrl;
  final String title;
  final int dietitionCount;
  bool isSelected;

  MenuModel({
    required this.iconUrl,
    required this.title,
    required this.dietitionCount,
    this.isSelected = false,
  });
}

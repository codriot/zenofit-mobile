class MenuModel {
  final String iconUrl;
  final String title;
  final int DietitianCount;
  bool isSelected;

  MenuModel({
    required this.iconUrl,
    required this.title,
    required this.DietitianCount,
    this.isSelected = false,
  });
}

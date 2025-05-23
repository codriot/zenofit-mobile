import '../recipe_model.dart';

class MealModel {
  final String title;
  String subtitle;
  final String imageKey;
  final int recommendedMinCalories;
  final int recommendedMaxCalories;
  List<RecipeModel> recommendedContents;

  MealModel({
    required this.title,
    required this.subtitle,
    required this.imageKey,
    required this.recommendedMinCalories,
    required this.recommendedMaxCalories,
    required this.recommendedContents,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imageKey': imageKey,
      'recommendedMinCalories': recommendedMinCalories,
      'recommendedMaxCalories': recommendedMaxCalories,
      'recommendedContents': recommendedContents.map((x) => x.toJson()).toList(),
    };
  }

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      title: json['title'],
      subtitle: json['subtitle'],
      imageKey: json['imageKey'],
      recommendedMinCalories: json['recommendedMinCalories'],
      recommendedMaxCalories: json['recommendedMaxCalories'],
      recommendedContents: (json['recommendedContents'] as List)
          .map((x) => RecipeModel.fromJson(x))
          .toList(),
    );
  }

  factory MealModel.fromType(String type) {
    switch (type) {
      case 'breakfast':
        return MealModel(
          title: 'Kahvaltı',
          subtitle: '',
          imageKey: 'breakfast',
          recommendedMinCalories: 300,
          recommendedMaxCalories: 500,
          recommendedContents: [], // API'den gelecek
        );
      case 'lunch':
        return MealModel(
          title: 'Öğle Yemeği',
          subtitle: '',
          imageKey: 'lunch',
          recommendedMinCalories: 800,
          recommendedMaxCalories: 1100,
          recommendedContents: [], // API'den gelecek
        );
      case 'dinner':
        return MealModel(
          title: 'Akşam Yemeği',
          subtitle: '',
          imageKey: 'dinner',
          recommendedMinCalories: 800,
          recommendedMaxCalories: 1100,
          recommendedContents: [], // API'den gelecek
        );
      default:
        throw ArgumentError('Invalid meal type');
    }
  }
} 
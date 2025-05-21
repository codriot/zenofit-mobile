class NutritionCaloriesModel {
  final double totalCalories;
  final Map<String, double> meals;
  final double bke;
  final double idealWeight;
  final double proteinNeed;
  final double carbsNeed;
  final double fatNeed;

  NutritionCaloriesModel({
    required this.totalCalories,
    required this.meals,
    required this.bke,
    required this.idealWeight,
    required this.proteinNeed,
    required this.carbsNeed,
    required this.fatNeed,
  });

  factory NutritionCaloriesModel.fromJson(Map<String, dynamic> json) {
    return NutritionCaloriesModel(
      totalCalories: (json['total_calories'] as num).toDouble(),
      meals: Map<String, double>.from(
        (json['meals'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, (value as num).toDouble()),
        ),
      ),
      bke: (json['bke'] as num).toDouble(),
      idealWeight: (json['ideal_weight'] as num).toDouble(),
      proteinNeed: (json['protein_need'] as num).toDouble(),
      carbsNeed: (json['carbs_need'] as num).toDouble(),
      fatNeed: (json['fat_need'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_calories': totalCalories,
      'meals': meals,
      'bke': bke,
      'ideal_weight': idealWeight,
      'protein_need': proteinNeed,
      'carbs_need': carbsNeed,
      'fat_need': fatNeed,
    };
  }
}

import 'package:flutter/material.dart';

class MealModel {
  final String title;
  final String subtitle;
  final String imageKey;
  final int recommendedMinCalories;
  final int recommendedMaxCalories;
  final List<MealContentModel> recommendedContents;

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
          .map((x) => MealContentModel.fromJson(x))
          .toList(),
    );
  }

  factory MealModel.fromType(String type) {
    switch (type) {
      case 'breakfast':
        return MealModel(
          title: 'Kahvaltı',
          subtitle: 'Önerilen Öğün - 300 / 500 kalori',
          imageKey: 'breakfast',
          recommendedMinCalories: 300,
          recommendedMaxCalories: 500,
          recommendedContents: [
            MealContentModel(
              title: 'Kahvaltı Tabağı',
              protein: 28,
              carbs: 128,
              fat: 18,
              backgroundColor: const Color(0xFFE67E22), // Turuncu
            ),
            MealContentModel(
              title: 'Sağlıklı Kahvaltı Kasesi',
              protein: 25,
              carbs: 115,
              fat: 15,
              backgroundColor: const Color(0xFF3498DB), // Mavi
            ),
            MealContentModel(
              title: 'Protein Kahvaltı',
              protein: 35,
              carbs: 85,
              fat: 20,
              backgroundColor: const Color(0xFFE59866), // Açık turuncu
            ),
            MealContentModel(
              title: 'Hafif Kahvaltı',
              protein: 18,
              carbs: 95,
              fat: 12,
              backgroundColor: const Color(0xFF82E0AA), // Yeşil
            ),
          ],
        );
      case 'lunch':
        return MealModel(
          title: 'Öğle Yemeği',
          subtitle: 'Önerilen Öğün - 800 / 1100 kalori',
          imageKey: 'lunch',
          recommendedMinCalories: 800,
          recommendedMaxCalories: 1100,
          recommendedContents: [
            MealContentModel(
              title: 'Izgara Tavuk Salata',
              protein: 45,
              carbs: 150,
              fat: 25,
              backgroundColor: const Color(0xFFE67E22),
            ),
            MealContentModel(
              title: 'Kinoalı Sebze Tabağı',
              protein: 35,
              carbs: 140,
              fat: 20,
              backgroundColor: const Color(0xFF3498DB),
            ),
            MealContentModel(
              title: 'Ton Balıklı Salata',
              protein: 40,
              carbs: 120,
              fat: 22,
              backgroundColor: const Color(0xFFE59866),
            ),
            MealContentModel(
              title: 'Mercimek Çorbası',
              protein: 25,
              carbs: 130,
              fat: 15,
              backgroundColor: const Color(0xFF82E0AA),
            ),
          ],
        );
      case 'snacks':
        return MealModel(
          title: 'Atıştırmalıklar',
          subtitle: 'Önerilen Öğün - 400 / 500 kalori',
          imageKey: 'snacks',
          recommendedMinCalories: 400,
          recommendedMaxCalories: 500,
          recommendedContents: [
            MealContentModel(
              title: 'Protein Bar ve Meyve',
              protein: 20,
              carbs: 80,
              fat: 12,
              backgroundColor: const Color(0xFFE67E22),
            ),
            MealContentModel(
              title: 'Yoğurt ve Kuruyemiş',
              protein: 15,
              carbs: 70,
              fat: 15,
              backgroundColor: const Color(0xFF3498DB),
            ),
            MealContentModel(
              title: 'Meyve Tabağı',
              protein: 8,
              carbs: 85,
              fat: 5,
              backgroundColor: const Color(0xFFE59866),
            ),
            MealContentModel(
              title: 'Smoothie Bowl',
              protein: 12,
              carbs: 75,
              fat: 8,
              backgroundColor: const Color(0xFF82E0AA),
            ),
          ],
        );
      case 'dinner':
        return MealModel(
          title: 'Akşam Yemeği',
          subtitle: 'Önerilen Öğün - 800 / 1100 kalori',
          imageKey: 'dinner',
          recommendedMinCalories: 800,
          recommendedMaxCalories: 1100,
          recommendedContents: [
            MealContentModel(
              title: 'Somon ve Sebzeli Pilav',
              protein: 45,
              carbs: 160,
              fat: 30,
              backgroundColor: const Color(0xFFE67E22),
            ),
            MealContentModel(
              title: 'Mercimek Çorbası ve Salata',
              protein: 35,
              carbs: 140,
              fat: 20,
              backgroundColor: const Color(0xFF3498DB),
            ),
            MealContentModel(
              title: 'Izgara Köfte',
              protein: 42,
              carbs: 130,
              fat: 28,
              backgroundColor: const Color(0xFFE59866),
            ),
            MealContentModel(
              title: 'Sebzeli Makarna',
              protein: 25,
              carbs: 150,
              fat: 18,
              backgroundColor: const Color(0xFF82E0AA),
            ),
          ],
        );
      default:
        throw ArgumentError('Invalid meal type');
    }
  }
}

class MealContentModel {
  final String title;
  final int protein;
  final int carbs;
  final int fat;
  final Color backgroundColor;
  bool isSelected;

  MealContentModel({
    required this.title,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.backgroundColor,
    this.isSelected = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'isSelected': isSelected,
      'backgroundColor': backgroundColor.value.toString(),
    };
  }

  factory MealContentModel.fromJson(Map<String, dynamic> json) {
    Color getColor(dynamic value) {
      if (value == null) return const Color(0xFFE67E22);
      if (value is String) {
        return Color(int.parse(value));
      }
      return Color(value as int);
    }

    return MealContentModel(
      title: json['title'],
      protein: json['protein'],
      carbs: json['carbs'],
      fat: json['fat'],
      isSelected: json['isSelected'] ?? false,
      backgroundColor: getColor(json['backgroundColor']),
    );
  }

  String get proteinText => '$protein gram';
  String get carbsText => '$carbs gram';
  String get fatText => '$fat gram';
} 
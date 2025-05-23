import 'package:flutter/material.dart';

class RecipeModel {
  final int recipeId;
  final String name;
  final String cookTime;
  final String prepTime;
  final String totalTime;
  final List<String> recipeIngredientParts;
  final double calories;
  final double fatContent;
  final double saturatedFatContent;
  final double cholesterolContent;
  final double sodiumContent;
  final double carbohydrateContent;
  final double fiberContent;
  final double sugarContent;
  final double proteinContent;
  final List<String> recipeInstructions;
  bool isSelected;
  Color backgroundColor;

  RecipeModel({
    required this.recipeId,
    required this.name,
    required this.cookTime,
    required this.prepTime,
    required this.totalTime,
    required this.recipeIngredientParts,
    required this.calories,
    required this.fatContent,
    required this.saturatedFatContent,
    required this.cholesterolContent,
    required this.sodiumContent,
    required this.carbohydrateContent,
    required this.fiberContent,
    required this.sugarContent,
    required this.proteinContent,
    required this.recipeInstructions,
    this.isSelected = false,
    this.backgroundColor = Colors.blue,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    // String formatındaki listeleri parse etme
    List<String> parseStringList(String str) {
      return str
          .replaceAll('c(', '')
          .replaceAll(')', '')
          .split(',')
          .map((e) => e.trim().replaceAll('"', ''))
          .toList();
    }

    return RecipeModel(
      recipeId: json['RecipeId'],
      name: json['Name'],
      cookTime: json['CookTime'],
      prepTime: json['PrepTime'],
      totalTime: json['TotalTime'],
      recipeIngredientParts: parseStringList(json['RecipeIngredientParts']),
      calories: json['Calories'].toDouble(),
      fatContent: json['FatContent'].toDouble(),
      saturatedFatContent: json['SaturatedFatContent'].toDouble(),
      cholesterolContent: json['CholesterolContent'].toDouble(),
      sodiumContent: json['SodiumContent'].toDouble(),
      carbohydrateContent: json['CarbohydrateContent'].toDouble(),
      fiberContent: json['FiberContent'].toDouble(),
      sugarContent: json['SugarContent'].toDouble(),
      proteinContent: json['ProteinContent'].toDouble(),
      recipeInstructions: parseStringList(json['RecipeInstructions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'RecipeId': recipeId,
      'Name': name,
      'CookTime': cookTime,
      'PrepTime': prepTime,
      'TotalTime': totalTime,
      'RecipeIngredientParts': recipeIngredientParts,
      'Calories': calories,
      'FatContent': fatContent,
      'SaturatedFatContent': saturatedFatContent,
      'CholesterolContent': cholesterolContent,
      'SodiumContent': sodiumContent,
      'CarbohydrateContent': carbohydrateContent,
      'FiberContent': fiberContent,
      'SugarContent': sugarContent,
      'ProteinContent': proteinContent,
      'RecipeInstructions': recipeInstructions,
    };
  }

  String get proteinText => '${proteinContent.toInt()} gram';
  String get carbsText => '${carbohydrateContent.toInt()} gram';
  String get fatText => '${fatContent.toInt()} gram';
  String get title => name; // View'da kullanılan title özelliği için
} 
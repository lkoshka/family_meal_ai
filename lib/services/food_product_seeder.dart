import 'dart:convert';

import 'package:flutter/services.dart';

import '../database/app_database.dart';

class FoodProductSeeder {
  static Future<void> seedIfNeeded(AppDatabase database) async {
    final jsonString = await rootBundle.loadString(
      'assets/data/food_products.json',
    );

    final List<dynamic> products = jsonDecode(jsonString);

    for (final item in products) {
      final product = item as Map<String, dynamic>;
      final name = product['name'] as String;

      final existing = await database.getFoodProductByName(name);

      if (existing != null) {
        await database.updateFoodProductCategory(
          id: existing.id,
          category: product['category'] as String,
        );
        continue;
      }

      await database.addFoodProduct(
        name: name,
        state: product['state'] as String,
        category: product['category'] as String,
        caloriesPer100g: (product['caloriesPer100g'] as num).toDouble(),
        proteinPer100g: (product['proteinPer100g'] as num).toDouble(),
        fatPer100g: (product['fatPer100g'] as num).toDouble(),
        carbsPer100g: (product['carbsPer100g'] as num).toDouble(),
        gramsPerMl: (product['gramsPerMl'] as num?)?.toDouble(),
      );
    }
  }
}

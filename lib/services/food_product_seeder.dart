import 'dart:convert';

import 'package:flutter/services.dart';

import '../database/app_database.dart';

class FoodProductSeeder {
  static Future<void> seedIfNeeded(AppDatabase database) async {
    final jsonString = await rootBundle.loadString(
      'assets/data/food_products.json',
    );

    final List<dynamic> products = jsonDecode(jsonString);

    const aliases = <String, List<String>>{
      'Куриная грудка': [
        'куриная грудка',
        'куриное филе',
        'филе курицы',
        'грудка куриная',
        'куриная грудка без кожи',
      ],
    };

    for (final item in products) {
      final product = item as Map<String, dynamic>;
      final name = product['name'] as String;

      final existing = await database.getFoodProductByName(name);

      late final int foodProductId;

      if (existing != null) {
        foodProductId = existing.id;

        await database.updateFoodProduct(
          id: existing.id,
          state: product['state'] as String,
          category: product['category'] as String,
          source: product['source'] as String,
          sourceId: product['sourceId'] as String?,
          caloriesPer100g: (product['caloriesPer100g'] as num).toDouble(),
          proteinPer100g: (product['proteinPer100g'] as num).toDouble(),
          fatPer100g: (product['fatPer100g'] as num).toDouble(),
          carbsPer100g: (product['carbsPer100g'] as num).toDouble(),
          gramsPerMl: (product['gramsPerMl'] as num?)?.toDouble(),
        );
      } else {
        foodProductId = await database.addFoodProduct(
          name: name,
          state: product['state'] as String,
          category: product['category'] as String,
          source: product['source'] as String,
          sourceId: product['sourceId'] as String?,
          caloriesPer100g: (product['caloriesPer100g'] as num).toDouble(),
          proteinPer100g: (product['proteinPer100g'] as num).toDouble(),
          fatPer100g: (product['fatPer100g'] as num).toDouble(),
          carbsPer100g: (product['carbsPer100g'] as num).toDouble(),
          gramsPerMl: (product['gramsPerMl'] as num?)?.toDouble(),
        );
      }

      for (final alias in aliases[name] ?? const <String>[]) {
        await database.addFoodProductAlias(
          foodProductId: foodProductId,
          alias: alias,
        );
      }
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'food_product_source.dart';

class UsdaFoodProductSource implements FoodProductSource {
  const UsdaFoodProductSource({required this.apiKey});

  final String apiKey;

  @override
  Future<FoodProductSourceResult?> findProduct(String name) async {
    final uri = Uri.https('api.nal.usda.gov', '/fdc/v1/foods/search', {
      'api_key': apiKey,
      'query': name,
      'pageSize': '10',
      'dataType': 'Foundation,SR Legacy',
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return null;
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final foods = json['foods'] as List<dynamic>?;

    if (foods == null || foods.isEmpty) {
      return null;
    }

    final food = _selectBestFood(name, foods);

    if (food == null) {
      return null;
    }
    final nutrients = food['foodNutrients'] as List<dynamic>? ?? const [];

    final calories = _findNutrientAmount(nutrients, 1008);
    final protein = _findNutrientAmount(nutrients, 1003);
    final fat = _findNutrientAmount(nutrients, 1004);
    final carbs = _findNutrientAmount(nutrients, 1005);

    if (calories == null || protein == null || fat == null || carbs == null) {
      return null;
    }

    return FoodProductSourceResult(
      name: food['description'] as String? ?? name,
      state: '',
      category: '',
      source: 'usda',
      sourceId: food['fdcId']?.toString(),
      caloriesPer100g: calories,
      proteinPer100g: protein,
      fatPer100g: fat,
      carbsPer100g: carbs,
    );
  }

  Map<String, dynamic>? _selectBestFood(String query, List<dynamic> foods) {
    final queryWords = query
        .toLowerCase()
        .split(RegExp(r'[\s,]+'))
        .where((word) => word.isNotEmpty)
        .toList();

    Map<String, dynamic>? bestFood;
    var bestScore = -1;

    for (final item in foods) {
      final food = item as Map<String, dynamic>;
      final description = (food['description'] as String? ?? '').toLowerCase();

      var score = 0;

      for (final word in queryWords) {
        if (description.contains(word)) {
          score += 10;
        }
      }

      if (description.contains('raw')) {
        score += 3;
      }

      if (description.contains('boneless')) {
        score += 2;
      }

      if (description.contains('skinless')) {
        score += 2;
      }

      if (description.contains('breaded')) {
        score -= 5;
      }

      if (description.contains('lunchmeat') || description.contains('deli')) {
        score -= 5;
      }

      if (score > bestScore) {
        bestScore = score;
        bestFood = food;
      }
    }

    return bestFood;
  }

  double? _findNutrientAmount(List<dynamic> nutrients, int nutrientId) {
    for (final item in nutrients) {
      final nutrient = item as Map<String, dynamic>;

      if (nutrient['nutrientId'] == nutrientId) {
        return (nutrient['value'] as num?)?.toDouble();
      }
    }

    return null;
  }
}

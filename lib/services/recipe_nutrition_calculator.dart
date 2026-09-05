import '../database/app_database.dart';

class RecipeNutritionResult {
  final double calories;
  final double protein;
  final double fat;
  final double carbs;

  const RecipeNutritionResult({
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
  });
}

class RecipeNutritionCalculator {
  static RecipeNutritionResult calculate(List<RecipeIngredient> ingredients) {
    double calories = 0;
    double protein = 0;
    double fat = 0;
    double carbs = 0;

    for (final ingredient in ingredients) {
      final weightGrams = ingredient.weightGrams;

      if (weightGrams == null) {
        continue;
      }

      final factor = weightGrams / 100;

      calories += (ingredient.caloriesPer100g ?? 0) * factor;
      protein += (ingredient.proteinPer100g ?? 0) * factor;
      fat += (ingredient.fatPer100g ?? 0) * factor;
      carbs += (ingredient.carbsPer100g ?? 0) * factor;
    }

    return RecipeNutritionResult(
      calories: calories,
      protein: protein,
      fat: fat,
      carbs: carbs,
    );
  }

  static RecipeNutritionResult calculatePerServing(
    List<RecipeIngredient> ingredients,
    int servings,
  ) {
    final total = calculate(ingredients);

    if (servings <= 0) {
      return total;
    }

    return RecipeNutritionResult(
      calories: total.calories / servings,
      protein: total.protein / servings,
      fat: total.fat / servings,
      carbs: total.carbs / servings,
    );
  }
}

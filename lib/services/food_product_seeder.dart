import '../database/app_database.dart';
import 'ingredient_nutrition_catalog.dart';

class FoodProductSeeder {
  static Future<void> seedIfNeeded(AppDatabase database) async {
    for (final entry in IngredientNutritionCatalog.products.entries) {
      final existing = await database.getFoodProductByName(entry.key);

      if (existing != null) {
        continue;
      }

      final nutrition = entry.value;

      await database.addFoodProduct(
        name: entry.key,
        state: nutrition.state.name,
        caloriesPer100g: nutrition.caloriesPer100g,
        proteinPer100g: nutrition.proteinPer100g,
        fatPer100g: nutrition.fatPer100g,
        carbsPer100g: nutrition.carbsPer100g,
        gramsPerMl: nutrition.gramsPerMl,
      );
    }
  }
}

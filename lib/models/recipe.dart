class Recipe {
  final String id;
  final String name;
  final String description;

  /// Ингредиенты базового рецепта.
  final List<RecipeIngredient> ingredients;

  /// На сколько стандартных порций рассчитан рецепт.
  final int servings;

  /// Пищевая ценность одной стандартной порции.
  final double caloriesPerServing;
  final double proteinPerServing;
  final double fatPerServing;
  final double carbsPerServing;

  /// Типы питания, с которыми совместим рецепт.
  /// Например: omnivore, keto, vegetarian.
  final Set<String> dietTypes;

  /// Аллергены, содержащиеся в рецепте.
  final Set<String> allergens;

  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.servings,
    required this.caloriesPerServing,
    required this.proteinPerServing,
    required this.fatPerServing,
    required this.carbsPerServing,
    this.dietTypes = const {},
    this.allergens = const {},
  });
}

class RecipeIngredient {
  final String name;

  /// Количество на весь базовый рецепт.
  final double amount;

  /// Например: г, мл, шт.
  final String unit;

  const RecipeIngredient({
    required this.name,
    required this.amount,
    required this.unit,
  });
}
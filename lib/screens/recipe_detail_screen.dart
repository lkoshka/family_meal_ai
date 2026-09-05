import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../services/recipe_nutrition_calculator.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  final AppDatabase _database = AppDatabase();

  List<RecipeIngredient> _ingredients = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadIngredients();
  }

  Future<void> _loadIngredients() async {
    final ingredients = await _database.getRecipeIngredients(widget.recipe.id);

    if (!mounted) {
      return;
    }

    setState(() {
      _ingredients = ingredients;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    final calculatedNutrition = RecipeNutritionCalculator.calculatePerServing(
      _ingredients,
      recipe.servings,
    );

    final hasCalculatedNutrition = _ingredients.any(
      (ingredient) =>
          ingredient.weightGrams != null && ingredient.caloriesPer100g != null,
    );
    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              if (recipe.description.isNotEmpty)
                Text(recipe.description, style: const TextStyle(fontSize: 16)),

              const SizedBox(height: 24),

              const Text(
                'Пищевая ценность одной порции',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '${(hasCalculatedNutrition ? calculatedNutrition.calories : recipe.caloriesPerServing).round()} ккал',
              ),
              Text(
                'Белки: ${(hasCalculatedNutrition ? calculatedNutrition.protein : recipe.proteinPerServing).round()} г',
              ),
              Text(
                'Жиры: ${(hasCalculatedNutrition ? calculatedNutrition.fat : recipe.fatPerServing).round()} г',
              ),
              Text(
                'Углеводы: ${(hasCalculatedNutrition ? calculatedNutrition.carbs : recipe.carbsPerServing).round()} г',
              ),
              const SizedBox(height: 8),

              Text(
                'Базовый рецепт: ${recipe.servings} порции',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),

              if (recipe.prepMinutes != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Время приготовления: ${recipe.prepMinutes} мин',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 28),

              const Text(
                'Ингредиенты',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_ingredients.isEmpty)
                const Text('Ингредиенты не указаны')
              else
                ..._ingredients.map(
                  (ingredient) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.circle, size: 7),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            ingredient.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Text(
                          '${_formatAmount(ingredient.amount)} '
                          '${ingredient.unit}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 28),

              const Text(
                'Приготовление',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              if (recipe.instructions.trim().isEmpty)
                const Text('Инструкция приготовления не указана')
              else
                Text(
                  recipe.instructions.trim(),
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount == amount.roundToDouble()) {
      return amount.round().toString();
    }

    return amount.toStringAsFixed(1);
  }
}

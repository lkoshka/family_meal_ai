import 'package:flutter/material.dart';

import '../database/app_database.dart';
import 'recipe_detail_screen.dart';
import '../services/family_meal_compatibility_service.dart';

class RecipesScreen extends StatefulWidget {
  final int familyId;

  const RecipesScreen({super.key, required this.familyId});
  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final AppDatabase _database = AppDatabase();

  List<Recipe> _recipes = [];
  List<FamilyMember> _members = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final recipes = await _database.getAllRecipes();
    final members = await _database.getFamilyMembers(widget.familyId);

    if (!mounted) {
      return;
    }

    setState(() {
      _recipes = recipes;
      _members = members;
      _isLoading = false;
    });
  }

  Future<FamilyMealCompatibilityResult> _checkCompatibility(
    Recipe recipe,
  ) async {
    final ingredients = await _database.getRecipeIngredients(recipe.id);

    return FamilyMealCompatibilityService.checkRecipe(
      recipe: recipe,
      members: _members,
      ingredients: ingredients,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Рецепты')),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _recipes.isEmpty
            ? const Center(
                child: Text(
                  'Рецептов пока нет',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  final recipe = _recipes[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        recipe.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (recipe.description.isNotEmpty)
                              Text(recipe.description),
                            const SizedBox(height: 8),
                            Text(
                              '${recipe.caloriesPerServing.round()} ккал · '
                              'Б ${recipe.proteinPerServing.round()} г · '
                              'Ж ${recipe.fatPerServing.round()} г · '
                              'У ${recipe.carbsPerServing.round()} г',
                            ),
                            const SizedBox(height: 4),
                            Text('Порций: ${recipe.servings}'),
                            const SizedBox(height: 8),
                            FutureBuilder<FamilyMealCompatibilityResult>(
                              future: _checkCompatibility(recipe),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Text(
                                    'Проверяем совместимость...',
                                    style: TextStyle(fontSize: 13),
                                  );
                                }

                                final result = snapshot.data!;

                                String text;

                                switch (result.level) {
                                  case MealCompatibilityLevel.compatible:
                                    text = 'Подходит всей семье';
                                    break;

                                  case MealCompatibilityLevel.needsAdaptation:
                                    text = 'Нужна адаптация';
                                    break;

                                  case MealCompatibilityLevel.incompatible:
                                    final reasons = result.members
                                        .where(
                                          (member) =>
                                              member.level ==
                                              MealCompatibilityLevel
                                                  .incompatible,
                                        )
                                        .expand(
                                          (
                                            member,
                                          ) => member.hardRestrictions.map(
                                            (reason) =>
                                                '${member.memberName}: $reason',
                                          ),
                                        )
                                        .join('; ');

                                    text = reasons.isEmpty
                                        ? 'Не подходит'
                                        : 'Не подходит — $reasons';
                                    break;
                                }

                                final adaptationLines = result.members
                                    .where(
                                      (member) =>
                                          member.level ==
                                              MealCompatibilityLevel
                                                  .needsAdaptation &&
                                          member
                                              .adaptationSuggestions
                                              .isNotEmpty,
                                    )
                                    .expand(
                                      (
                                        member,
                                      ) => member.adaptationSuggestions.map(
                                        (suggestion) =>
                                            '${member.memberName}: $suggestion',
                                      ),
                                    )
                                    .toList();

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      text,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (adaptationLines.isNotEmpty) ...[
                                      const SizedBox(height: 6),
                                      ...adaptationLines.map(
                                        (line) => Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 3,
                                          ),
                                          child: Text(
                                            '• $line',
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecipeDetailScreen(recipe: recipe),
                          ),
                        );
                      },
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

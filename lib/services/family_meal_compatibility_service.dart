import 'dart:convert';

import '../database/app_database.dart';

enum MealCompatibilityLevel { compatible, needsAdaptation, incompatible }

class MemberMealCompatibility {
  final int memberId;
  final String memberName;
  final MealCompatibilityLevel level;
  final List<String> hardRestrictions;
  final List<String> dislikedMatches;
  final List<String> likedMatches;
  final List<String> adaptationSuggestions;

  const MemberMealCompatibility({
    required this.memberId,
    required this.memberName,
    required this.level,
    required this.hardRestrictions,
    required this.dislikedMatches,
    required this.likedMatches,
    required this.adaptationSuggestions,
  });
}

class FamilyMealCompatibilityResult {
  final MealCompatibilityLevel level;
  final List<MemberMealCompatibility> members;

  const FamilyMealCompatibilityResult({
    required this.level,
    required this.members,
  });
}

class FamilyMealCompatibilityService {
  static FamilyMealCompatibilityResult checkRecipe({
    required Recipe recipe,
    required List<FamilyMember> members,
    required List<RecipeIngredient> ingredients,
  }) {
    final memberResults = <MemberMealCompatibility>[];

    for (final member in members) {
      memberResults.add(
        _checkMember(recipe: recipe, member: member, ingredients: ingredients),
      );
    }

    MealCompatibilityLevel familyLevel = MealCompatibilityLevel.compatible;

    if (memberResults.any(
      (result) => result.level == MealCompatibilityLevel.incompatible,
    )) {
      familyLevel = MealCompatibilityLevel.incompatible;
    } else if (memberResults.any(
      (result) => result.level == MealCompatibilityLevel.needsAdaptation,
    )) {
      familyLevel = MealCompatibilityLevel.needsAdaptation;
    }

    return FamilyMealCompatibilityResult(
      level: familyLevel,
      members: memberResults,
    );
  }

  static MemberMealCompatibility _checkMember({
    required Recipe recipe,
    required FamilyMember member,
    required List<RecipeIngredient> ingredients,
  }) {
    final hardRestrictions = <String>[];
    final dislikedMatches = <String>[];
    final likedMatches = <String>[];
    final adaptationSuggestions = <String>[];

    final ingredientNames = ingredients
        .map((ingredient) => _normalize(ingredient.name))
        .toList();

    final allergies = _parseList(member.allergies);
    final intolerances = _parseList(member.intolerances);
    final dislikedFoods = _parseList(member.dislikedFoods);
    final likedFoods = _parseList(member.likedFoods);

    final recipeAllergens = _splitTags(recipe.allergens);

    for (final allergy in allergies) {
      if (_matchesAny(recipeAllergens, allergy) ||
          _matchesIngredient(ingredientNames, allergy)) {
        hardRestrictions.add('аллергия: $allergy');
      }
    }

    for (final intolerance in intolerances) {
      if (_matchesAny(recipeAllergens, intolerance) ||
          _matchesIngredient(ingredientNames, intolerance)) {
        hardRestrictions.add('непереносимость: $intolerance');
      }
    }

    final dietNeedsAdaptation = !_dietCompatible(
      memberDietType: member.dietType,
      recipeDietTypes: recipe.dietTypes,
    );

    if (dietNeedsAdaptation) {
      adaptationSuggestions.addAll(
        _dietAdaptations(
          dietType: member.dietType,
          ingredients: ingredientNames,
        ),
      );
    }

    for (final disliked in dislikedFoods) {
      if (_matchesIngredient(ingredientNames, disliked)) {
        dislikedMatches.add(disliked);

        adaptationSuggestions.add(
          _dislikedFoodAdaptation(disliked, dietType: member.dietType),
        );
      }
    }

    for (final liked in likedFoods) {
      if (_matchesIngredient(ingredientNames, liked)) {
        likedMatches.add(liked);
      }
    }

    MealCompatibilityLevel level;

    if (hardRestrictions.isNotEmpty) {
      level = MealCompatibilityLevel.incompatible;
    } else if (dietNeedsAdaptation || dislikedMatches.isNotEmpty) {
      level = MealCompatibilityLevel.needsAdaptation;
    } else {
      level = MealCompatibilityLevel.compatible;
    }

    return MemberMealCompatibility(
      memberId: member.id,
      memberName: member.name,
      level: level,
      hardRestrictions: hardRestrictions,
      dislikedMatches: dislikedMatches,
      likedMatches: likedMatches,
      adaptationSuggestions: adaptationSuggestions.toSet().toList(),
    );
  }

  static List<String> _dietAdaptations({
    required String? dietType,
    required List<String> ingredients,
  }) {
    final diet = _normalize(dietType ?? '');
    final suggestions = <String>[];

    if (diet == 'keto' || diet == 'кето') {
      for (final ingredient in ingredients) {
        if (_containsAny(ingredient, ['картофель', 'картошка'])) {
          suggestions.add('картофель заменить на цветную капусту или брокколи');
        }

        if (_containsAny(ingredient, ['рис'])) {
          suggestions.add('рис заменить на рис из цветной капусты');
        }

        if (_containsAny(ingredient, ['паста', 'макарон', 'спагетти'])) {
          suggestions.add('пасту заменить на кабачковую лапшу или ширатаки');
        }

        if (_containsAny(ingredient, ['греч'])) {
          suggestions.add(
            'гречку заменить на брокколи, цветную капусту или салат',
          );
        }

        if (_containsAny(ingredient, ['кускус'])) {
          suggestions.add('кускус заменить на измельчённую цветную капусту');
        }

        if (_containsAny(ingredient, ['чечевиц'])) {
          suggestions.add(
            'чечевицу заменить на низкоуглеводные овощи и подходящий белок',
          );
        }
      }

      if (suggestions.isEmpty) {
        suggestions.add(
          'уменьшить углеводные компоненты и увеличить долю белка и низкоуглеводных овощей',
        );
      }
    }

    if (diet == 'vegetarian' || diet == 'вегетарианское') {
      for (final ingredient in ingredients) {
        if (_containsAny(ingredient, [
          'куриц',
          'индейк',
          'говядин',
          'свинин',
        ])) {
          suggestions.add(
            'мясо заменить на тофу, яйца, сыр или другой подходящий источник белка',
          );
        }
      }
    }

    if (diet == 'vegan' || diet == 'веганское') {
      for (final ingredient in ingredients) {
        if (_containsAny(ingredient, [
          'куриц',
          'индейк',
          'говядин',
          'свинин',
          'рыб',
          'лосос',
          'сыр',
          'молок',
          'яйц',
        ])) {
          suggestions.add(
            'животный продукт заменить на подходящий растительный аналог',
          );
        }
      }
    }

    if (diet == 'pescatarian' || diet == 'пескетарианское') {
      for (final ingredient in ingredients) {
        if (_containsAny(ingredient, [
          'куриц',
          'индейк',
          'говядин',
          'свинин',
        ])) {
          suggestions.add(
            'мясо заменить на рыбу или другой подходящий источник белка',
          );
        }
      }
    }

    return suggestions;
  }

  static String _dislikedFoodAdaptation(
    String disliked, {
    required String? dietType,
  }) {
    final food = _normalize(disliked);
    final diet = _normalize(dietType ?? '');

    if (_containsAny(food, ['картофель', 'картошка'])) {
      if (diet == 'keto' || diet == 'кето') {
        return 'нелюбимый картофель заменить на цветную капусту или брокколи';
      }

      return 'нелюбимый картофель заменить на рис, гречку или другой гарнир';
    }

    if (_containsAny(food, ['рис'])) {
      if (diet == 'keto' || diet == 'кето') {
        return 'рис заменить на рис из цветной капусты';
      }

      return 'рис заменить на картофель, гречку или другой подходящий гарнир';
    }

    if (_containsAny(food, ['макарон', 'паста', 'спагетти'])) {
      return 'пасту заменить на другой подходящий гарнир';
    }

    return 'заменить нелюбимый продукт "$disliked" подходящим аналогом';
  }

  static bool _dietCompatible({
    required String? memberDietType,
    required String? recipeDietTypes,
  }) {
    final diet = _normalize(memberDietType ?? '');

    if (diet.isEmpty ||
        diet == 'omnivore' ||
        diet == 'обычное питание' ||
        diet == 'обычный' ||
        diet == 'без ограничений') {
      return true;
    }

    final recipeDiets = _splitTags(recipeDietTypes);

    if (diet == 'vegetarian' || diet == 'вегетарианское') {
      return recipeDiets.contains('vegetarian') ||
          recipeDiets.contains('vegan');
    }

    if (diet == 'vegan' || diet == 'веганское') {
      return recipeDiets.contains('vegan');
    }

    if (diet == 'pescatarian' || diet == 'пескетарианское') {
      return recipeDiets.contains('pescatarian') ||
          recipeDiets.contains('vegetarian') ||
          recipeDiets.contains('vegan');
    }

    if (diet == 'keto' || diet == 'кето') {
      return recipeDiets.contains('keto');
    }

    if (diet == 'mediterranean' || diet == 'средиземноморское') {
      return recipeDiets.contains('mediterranean');
    }

    return recipeDiets.contains(diet);
  }

  static Set<String> _splitTags(String? value) {
    if (value == null || value.trim().isEmpty) {
      return {};
    }

    return value
        .split(',')
        .map(_normalize)
        .where((item) => item.isNotEmpty)
        .toSet();
  }

  static Set<String> _parseList(String? value) {
    if (value == null || value.trim().isEmpty) {
      return {};
    }

    final trimmed = value.trim();

    try {
      final decoded = jsonDecode(trimmed);

      if (decoded is List) {
        return decoded
            .map((item) => _normalize(item.toString()))
            .where((item) => item.isNotEmpty)
            .toSet();
      }
    } catch (_) {}

    return trimmed
        .split(RegExp(r'[,;]'))
        .map(_normalize)
        .where((item) => item.isNotEmpty)
        .toSet();
  }

  static bool _matchesAny(Set<String> values, String target) {
    final normalizedTarget = _normalize(target);

    return values.any(
      (value) =>
          value == normalizedTarget ||
          value.contains(normalizedTarget) ||
          normalizedTarget.contains(value),
    );
  }

  static bool _matchesIngredient(List<String> ingredients, String target) {
    final normalizedTarget = _normalize(target);

    return ingredients.any(
      (ingredient) =>
          ingredient == normalizedTarget ||
          ingredient.contains(normalizedTarget) ||
          normalizedTarget.contains(ingredient),
    );
  }

  static bool _containsAny(String value, List<String> variants) {
    final normalized = _normalize(value);

    return variants.any((variant) => normalized.contains(_normalize(variant)));
  }

  static String _normalize(String value) {
    return value.trim().toLowerCase();
  }
}

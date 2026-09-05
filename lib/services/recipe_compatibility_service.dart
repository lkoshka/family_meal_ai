import 'dart:convert';

import '../database/app_database.dart';

class RecipeCompatibilityResult {
  final bool isCompatible;
  final List<String> reasons;

  const RecipeCompatibilityResult({
    required this.isCompatible,
    required this.reasons,
  });
}

class RecipeCompatibilityService {
  static RecipeCompatibilityResult checkRecipeForFamily({
    required Recipe recipe,
    required List<FamilyMember> members,
  }) {
    final reasons = <String>[];

    for (final member in members) {
      final memberReasons = _checkRecipeForMember(
        recipe: recipe,
        member: member,
      );

      for (final reason in memberReasons) {
        reasons.add('${member.name}: $reason');
      }
    }

    return RecipeCompatibilityResult(
      isCompatible: reasons.isEmpty,
      reasons: reasons,
    );
  }

  static List<String> _checkRecipeForMember({
    required Recipe recipe,
    required FamilyMember member,
  }) {
    final reasons = <String>[];

    final recipeAllergens = _splitRecipeTags(recipe.allergens);
    final memberAllergies = _parseMemberList(member.allergies);
    final memberIntolerances = _parseMemberList(member.intolerances);

    for (final allergy in memberAllergies) {
      if (_containsMatchingValue(recipeAllergens, allergy)) {
        reasons.add('аллергия: $allergy');
      }
    }

    for (final intolerance in memberIntolerances) {
      if (_containsMatchingValue(recipeAllergens, intolerance)) {
        reasons.add('непереносимость: $intolerance');
      }
    }

    final dietType = member.dietType?.trim().toLowerCase();

    if (dietType != null && dietType.isNotEmpty) {
      final recipeDietTypes = _splitRecipeTags(recipe.dietTypes);

      if (!_isDietCompatible(
        memberDietType: dietType,
        recipeDietTypes: recipeDietTypes,
      )) {
        reasons.add('не подходит по типу питания');
      }
    }

    return reasons;
  }

  static bool _isDietCompatible({
    required String memberDietType,
    required Set<String> recipeDietTypes,
  }) {
    final diet = _normalize(memberDietType);

    if (diet.isEmpty ||
        diet == 'omnivore' ||
        diet == 'обычное питание' ||
        diet == 'обычный' ||
        diet == 'без ограничений') {
      return true;
    }

    if (diet == 'vegetarian' || diet == 'вегетарианское') {
      return recipeDietTypes.contains('vegetarian') ||
          recipeDietTypes.contains('vegan');
    }

    if (diet == 'vegan' || diet == 'веганское') {
      return recipeDietTypes.contains('vegan');
    }

    if (diet == 'pescatarian' || diet == 'пескетарианское') {
      return recipeDietTypes.contains('pescatarian') ||
          recipeDietTypes.contains('vegetarian') ||
          recipeDietTypes.contains('vegan');
    }

    if (diet == 'keto' || diet == 'кето') {
      return recipeDietTypes.contains('keto');
    }

    if (diet == 'mediterranean' || diet == 'средиземноморское') {
      return recipeDietTypes.contains('mediterranean');
    }

    return recipeDietTypes.contains(diet);
  }

  static Set<String> _splitRecipeTags(String? value) {
    if (value == null || value.trim().isEmpty) {
      return {};
    }

    return value
        .split(',')
        .map(_normalize)
        .where((item) => item.isNotEmpty)
        .toSet();
  }

  static Set<String> _parseMemberList(String? value) {
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
    } catch (_) {
      // Если старые данные были сохранены не как JSON,
      // попробуем разобрать их как обычную строку.
    }

    return trimmed
        .split(RegExp(r'[,;]'))
        .map(_normalize)
        .where((item) => item.isNotEmpty)
        .toSet();
  }

  static bool _containsMatchingValue(
    Set<String> recipeValues,
    String memberValue,
  ) {
    final normalizedMemberValue = _normalize(memberValue);

    for (final recipeValue in recipeValues) {
      if (recipeValue == normalizedMemberValue) {
        return true;
      }

      if (recipeValue.contains(normalizedMemberValue) ||
          normalizedMemberValue.contains(recipeValue)) {
        return true;
      }
    }

    return false;
  }

  static String _normalize(String value) {
    return value.trim().toLowerCase();
  }
}

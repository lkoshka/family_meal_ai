import '../database/app_database.dart';
import 'nutrition_calculator.dart';

class FamilyMealPortion {
  final int memberId;
  final String memberName;

  final double calories;
  final double proteinGrams;
  final double fatGrams;
  final double carbsGrams;

  final double portionFactor;

  const FamilyMealPortion({
    required this.memberId,
    required this.memberName,
    required this.calories,
    required this.proteinGrams,
    required this.fatGrams,
    required this.carbsGrams,
    required this.portionFactor,
  });
}

class FamilyMealPlan {
  final List<FamilyMealPortion> portions;

  const FamilyMealPlan({required this.portions});
}

class FamilyMenuPlanner {
  static FamilyMealPlan createMealPlan({
    required List<FamilyMember> members,
    double mealShare = 0.30,
  }) {
    if (members.isEmpty) {
      return const FamilyMealPlan(portions: []);
    }

    final targets = <FamilyMember, NutritionTargets>{};

    for (final member in members) {
      targets[member] = NutritionCalculator.calculate(member);
    }

    final averageCalories =
        targets.values
            .map((target) => target.calories)
            .reduce((a, b) => a + b) /
        targets.length;

    final portions = <FamilyMealPortion>[];

    for (final member in members) {
      final target = targets[member]!;

      final mealCalories = target.calories * mealShare;
      final mealProtein = target.proteinGrams * mealShare;
      final mealFat = target.fatGrams * mealShare;
      final mealCarbs = target.carbsGrams * mealShare;

      final portionFactor = target.calories / averageCalories;

      portions.add(
        FamilyMealPortion(
          memberId: member.id,
          memberName: member.name,
          calories: mealCalories,
          proteinGrams: mealProtein,
          fatGrams: mealFat,
          carbsGrams: mealCarbs,
          portionFactor: portionFactor,
        ),
      );
    }

    return FamilyMealPlan(portions: portions);
  }
}

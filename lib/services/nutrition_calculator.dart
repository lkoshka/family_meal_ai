import '../database/app_database.dart';

class NutritionTargets {
  final double calories;
  final double proteinGrams;
  final double fatGrams;
  final double carbsGrams;

  const NutritionTargets({
    required this.calories,
    required this.proteinGrams,
    required this.fatGrams,
    required this.carbsGrams,
  });
}

enum _PalCategory { inactive, lowActive, active, veryActive }

class NutritionCalculator {
  static NutritionTargets calculate(FamilyMember member) {
    if (member.birthDate == null ||
        member.gender == null ||
        member.heightCm == null ||
        member.weightKg == null) {
      throw ArgumentError('Недостаточно данных для расчёта питания');
    }

    final ageYears = _exactAge(member.birthDate!);
    final age = _completedYears(member.birthDate!);

    if (ageYears < 3) {
      throw ArgumentError(
        'Автоматический расчёт для детей младше 3 лет пока недоступен',
      );
    }

    final gender = member.gender!;
    final heightCm = member.heightCm!;
    final weightKg = member.weightKg!;
    final pal = _palCategory(member.activity);

    double calories;

    if (ageYears < 19) {
      calories = _pediatricEer(
        gender: gender,
        ageYears: ageYears,
        completedAge: age,
        heightCm: heightCm,
        weightKg: weightKg,
        pal: pal,
      );

      calories = _applyPediatricGoal(calories: calories, goal: member.goal);
    } else {
      calories = _adultEer(
        gender: gender,
        ageYears: ageYears,
        heightCm: heightCm,
        weightKg: weightKg,
        pal: pal,
      );

      calories = _applyAdultGoal(calories: calories, goal: member.goal);
    }

    final protein = _proteinTarget(
      weightKg: weightKg,
      age: age,
      goal: member.goal,
    );

    final fat = _fatTarget(calories: calories, age: age);

    final proteinCalories = protein * 4;
    final fatCalories = fat * 9;

    final remainingCalories = calories - proteinCalories - fatCalories;

    final carbs = remainingCalories > 0 ? remainingCalories / 4 : 0.0;

    return NutritionTargets(
      calories: calories,
      proteinGrams: protein,
      fatGrams: fat,
      carbsGrams: carbs,
    );
  }

  static int _completedYears(DateTime birthDate) {
    final today = DateTime.now();

    var age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  static double _exactAge(DateTime birthDate) {
    final today = DateTime.now();

    final days = today.difference(birthDate).inDays;

    return days / 365.2425;
  }

  static _PalCategory _palCategory(String? activity) {
    switch (activity) {
      case 'sedentary':
        return _PalCategory.inactive;

      case 'light':
        return _PalCategory.lowActive;

      case 'moderate':
        return _PalCategory.active;

      case 'high':
      case 'very_high':
        return _PalCategory.veryActive;

      default:
        return _PalCategory.inactive;
    }
  }

  static double _pediatricEer({
    required String gender,
    required double ageYears,
    required int completedAge,
    required double heightCm,
    required double weightKg,
    required _PalCategory pal,
  }) {
    final tee = gender == 'male'
        ? _boysTee(
            ageYears: ageYears,
            heightCm: heightCm,
            weightKg: weightKg,
            pal: pal,
          )
        : _girlsTee(
            ageYears: ageYears,
            heightCm: heightCm,
            weightKg: weightKg,
            pal: pal,
          );

    final growth = _growthEnergy(gender: gender, age: completedAge);

    return tee + growth;
  }

  static double _boysTee({
    required double ageYears,
    required double heightCm,
    required double weightKg,
    required _PalCategory pal,
  }) {
    switch (pal) {
      case _PalCategory.inactive:
        return -447.51 +
            (3.68 * ageYears) +
            (13.01 * heightCm) +
            (13.15 * weightKg);

      case _PalCategory.lowActive:
        return 19.12 +
            (3.68 * ageYears) +
            (8.62 * heightCm) +
            (20.28 * weightKg);

      case _PalCategory.active:
        return -388.19 +
            (3.68 * ageYears) +
            (12.66 * heightCm) +
            (20.46 * weightKg);

      case _PalCategory.veryActive:
        return -671.75 +
            (3.68 * ageYears) +
            (15.38 * heightCm) +
            (23.25 * weightKg);
    }
  }

  static double _girlsTee({
    required double ageYears,
    required double heightCm,
    required double weightKg,
    required _PalCategory pal,
  }) {
    switch (pal) {
      case _PalCategory.inactive:
        return 55.59 -
            (22.25 * ageYears) +
            (8.43 * heightCm) +
            (17.07 * weightKg);

      case _PalCategory.lowActive:
        return -297.54 -
            (22.25 * ageYears) +
            (12.77 * heightCm) +
            (14.73 * weightKg);

      case _PalCategory.active:
        return -189.55 -
            (22.25 * ageYears) +
            (11.74 * heightCm) +
            (18.34 * weightKg);

      case _PalCategory.veryActive:
        return -709.59 -
            (22.25 * ageYears) +
            (18.22 * heightCm) +
            (14.25 * weightKg);
    }
  }

  static double _growthEnergy({required String gender, required int age}) {
    if (gender == 'male') {
      if (age == 3) {
        return 20;
      }

      if (age >= 4 && age <= 8) {
        return 15;
      }

      if (age >= 9 && age <= 13) {
        return 25;
      }

      if (age >= 14 && age <= 18) {
        return 20;
      }
    } else {
      if (age == 3) {
        return 15;
      }

      if (age >= 4 && age <= 8) {
        return 15;
      }

      if (age >= 9 && age <= 13) {
        return 30;
      }

      if (age >= 14 && age <= 18) {
        return 20;
      }
    }

    return 0;
  }

  static double _adultEer({
    required String gender,
    required double ageYears,
    required double heightCm,
    required double weightKg,
    required _PalCategory pal,
  }) {
    if (gender == 'male') {
      switch (pal) {
        case _PalCategory.inactive:
          return 753.07 -
              (10.83 * ageYears) +
              (6.50 * heightCm) +
              (14.10 * weightKg);

        case _PalCategory.lowActive:
          return 581.47 -
              (10.83 * ageYears) +
              (8.30 * heightCm) +
              (14.94 * weightKg);

        case _PalCategory.active:
          return 1004.82 -
              (10.83 * ageYears) +
              (6.52 * heightCm) +
              (15.91 * weightKg);

        case _PalCategory.veryActive:
          return -517.88 -
              (10.83 * ageYears) +
              (15.61 * heightCm) +
              (19.11 * weightKg);
      }
    }

    switch (pal) {
      case _PalCategory.inactive:
        return 584.90 -
            (7.01 * ageYears) +
            (5.72 * heightCm) +
            (11.71 * weightKg);

      case _PalCategory.lowActive:
        return 575.77 -
            (7.01 * ageYears) +
            (6.60 * heightCm) +
            (12.14 * weightKg);

      case _PalCategory.active:
        return 710.25 -
            (7.01 * ageYears) +
            (6.54 * heightCm) +
            (12.34 * weightKg);

      case _PalCategory.veryActive:
        return 511.83 -
            (7.01 * ageYears) +
            (9.07 * heightCm) +
            (12.56 * weightKg);
    }
  }

  static double _applyAdultGoal({
    required double calories,
    required String? goal,
  }) {
    switch (goal) {
      case 'weight_loss':
        return calories * 0.85;

      case 'weight_gain':
        return calories * 1.10;

      case 'muscle':
        return calories * 1.08;

      case 'maintenance':
      case 'healthy':
      default:
        return calories;
    }
  }

  static double _applyPediatricGoal({
    required double calories,
    required String? goal,
  }) {
    switch (goal) {
      case 'weight_loss':
        // Для ребёнка/подростка пока не создаём
        // автоматический дефицит только по факту выбора цели.
        //
        // Для безопасного дефицита сначала понадобится
        // BMI-for-age percentile / z-score и отдельная
        // стратегия для избыточного веса или ожирения.
        return calories;

      case 'weight_gain':
      case 'muscle':
      case 'maintenance':
      case 'healthy':
      default:
        return calories;
    }
  }

  static double _proteinTarget({
    required double weightKg,
    required int age,
    required String? goal,
  }) {
    if (age <= 13) {
      return weightKg * 0.95;
    }

    if (age <= 18) {
      return weightKg * 0.85;
    }

    double gramsPerKg;

    switch (goal) {
      case 'weight_loss':
        gramsPerKg = 1.6;
        break;

      case 'muscle':
        gramsPerKg = 1.8;
        break;

      case 'weight_gain':
        gramsPerKg = 1.5;
        break;

      default:
        gramsPerKg = 1.2;
    }

    if (age >= 65 && gramsPerKg < 1.2) {
      gramsPerKg = 1.2;
    }

    return weightKg * gramsPerKg;
  }

  static double _fatTarget({required double calories, required int age}) {
    double fatPercent;

    if (age <= 18) {
      fatPercent = 0.30;
    } else {
      fatPercent = 0.30;
    }

    return calories * fatPercent / 9;
  }
}

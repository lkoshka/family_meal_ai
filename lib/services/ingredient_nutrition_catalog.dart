enum IngredientState { raw, dry, asSold }

class IngredientNutrition {
  final IngredientState state;
  final double caloriesPer100g;
  final double proteinPer100g;
  final double fatPer100g;
  final double carbsPer100g;
  final double? gramsPerMl;

  const IngredientNutrition({
    this.state = IngredientState.raw,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.fatPer100g,
    required this.carbsPer100g,
    this.gramsPerMl,
  });
}

class IngredientNutritionCatalog {
  static const Map<String, IngredientNutrition> products = {
    'Куриная грудка': IngredientNutrition(
      caloriesPer100g: 165,
      proteinPer100g: 31,
      fatPer100g: 3.6,
      carbsPer100g: 0,
    ),
    'Куриное филе': IngredientNutrition(
      caloriesPer100g: 165,
      proteinPer100g: 31,
      fatPer100g: 3.6,
      carbsPer100g: 0,
    ),
    'Курица': IngredientNutrition(
      caloriesPer100g: 165,
      proteinPer100g: 31,
      fatPer100g: 3.6,
      carbsPer100g: 0,
    ),
    'Филе индейки': IngredientNutrition(
      caloriesPer100g: 135,
      proteinPer100g: 29,
      fatPer100g: 1.6,
      carbsPer100g: 0,
    ),
    'Лосось': IngredientNutrition(
      caloriesPer100g: 208,
      proteinPer100g: 20,
      fatPer100g: 13,
      carbsPer100g: 0,
    ),
    'Филе белой рыбы': IngredientNutrition(
      caloriesPer100g: 100,
      proteinPer100g: 22,
      fatPer100g: 1.5,
      carbsPer100g: 0,
    ),
    'Говядина': IngredientNutrition(
      caloriesPer100g: 187,
      proteinPer100g: 26,
      fatPer100g: 9,
      carbsPer100g: 0,
    ),
    'Рис': IngredientNutrition(
      state: IngredientState.dry,
      caloriesPer100g: 360,
      proteinPer100g: 7,
      fatPer100g: 0.7,
      carbsPer100g: 79,
    ),
    'Гречка': IngredientNutrition(
      state: IngredientState.dry,
      caloriesPer100g: 343,
      proteinPer100g: 13,
      fatPer100g: 3.4,
      carbsPer100g: 72,
    ),
    'Кускус': IngredientNutrition(
      state: IngredientState.dry,
      caloriesPer100g: 376,
      proteinPer100g: 12.8,
      fatPer100g: 0.6,
      carbsPer100g: 77.4,
    ),
    'Чечевица': IngredientNutrition(
      state: IngredientState.dry,
      caloriesPer100g: 353,
      proteinPer100g: 25,
      fatPer100g: 1.1,
      carbsPer100g: 60,
    ),
    'Паста': IngredientNutrition(
      state: IngredientState.dry,
      caloriesPer100g: 350,
      proteinPer100g: 12,
      fatPer100g: 1.5,
      carbsPer100g: 72,
    ),
    'Картофель': IngredientNutrition(
      caloriesPer100g: 77,
      proteinPer100g: 2,
      fatPer100g: 0.1,
      carbsPer100g: 17.5,
    ),
    'Морковь': IngredientNutrition(
      caloriesPer100g: 41,
      proteinPer100g: 0.9,
      fatPer100g: 0.2,
      carbsPer100g: 9.6,
    ),
    'Лук': IngredientNutrition(
      caloriesPer100g: 40,
      proteinPer100g: 1.1,
      fatPer100g: 0.1,
      carbsPer100g: 9.3,
    ),
    'Кабачок': IngredientNutrition(
      caloriesPer100g: 17,
      proteinPer100g: 1.2,
      fatPer100g: 0.3,
      carbsPer100g: 3.1,
    ),
    'Брокколи': IngredientNutrition(
      caloriesPer100g: 34,
      proteinPer100g: 2.8,
      fatPer100g: 0.4,
      carbsPer100g: 6.6,
    ),
    'Перец': IngredientNutrition(
      caloriesPer100g: 31,
      proteinPer100g: 1,
      fatPer100g: 0.3,
      carbsPer100g: 6,
    ),
    'Баклажан': IngredientNutrition(
      caloriesPer100g: 25,
      proteinPer100g: 1,
      fatPer100g: 0.2,
      carbsPer100g: 6,
    ),
    'Томаты': IngredientNutrition(
      caloriesPer100g: 18,
      proteinPer100g: 0.9,
      fatPer100g: 0.2,
      carbsPer100g: 3.9,
    ),
    'Томатный соус': IngredientNutrition(
      caloriesPer100g: 35,
      proteinPer100g: 1.5,
      fatPer100g: 0.2,
      carbsPer100g: 7,
    ),
    'Пармезан': IngredientNutrition(
      state: IngredientState.asSold,
      caloriesPer100g: 431,
      proteinPer100g: 38,
      fatPer100g: 29,
      carbsPer100g: 4.1,
    ),
    'Оливковое масло': IngredientNutrition(
      state: IngredientState.asSold,
      gramsPerMl: 0.91,
      caloriesPer100g: 884,
      proteinPer100g: 0,
      fatPer100g: 100,
      carbsPer100g: 0,
    ),
  };
}

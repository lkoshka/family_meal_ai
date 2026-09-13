class FoodProductSourceResult {
  const FoodProductSourceResult({
    required this.name,
    required this.state,
    required this.category,
    required this.source,
    required this.sourceId,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.fatPer100g,
    required this.carbsPer100g,
    this.gramsPerMl,
  });

  final String name;
  final String state;
  final String category;
  final String source;
  final String? sourceId;
  final double caloriesPer100g;
  final double proteinPer100g;
  final double fatPer100g;
  final double carbsPer100g;
  final double? gramsPerMl;
}

abstract class FoodProductSource {
  Future<FoodProductSourceResult?> findProduct(String name);
}

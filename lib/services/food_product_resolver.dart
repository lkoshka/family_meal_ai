import '../database/app_database.dart';
import 'food_product_source.dart';

class FoodProductResolver {
  const FoodProductResolver(this.database, {this.source});

  final AppDatabase database;
  final FoodProductSource? source;

  Future<List<UnknownFoodProduct>> getPendingProducts() async {
    final unknownProducts = await database.getAllUnknownFoodProducts();

    return unknownProducts
        .where((product) => product.status == 'pending')
        .toList();
  }

  Future<bool> resolveFromLocalCatalog(
    UnknownFoodProduct unknownProduct,
  ) async {
    final foodProduct = await database.getFoodProductByNameOrAlias(
      unknownProduct.name,
    );

    if (foodProduct == null) {
      return false;
    }

    await database.markUnknownFoodProductResolved(
      unknownFoodProductId: unknownProduct.id,
      foodProductId: foodProduct.id,
    );

    return true;
  }

  Future<bool> resolveFromExternalSource(
    UnknownFoodProduct unknownProduct,
  ) async {
    final externalSource = source;

    if (externalSource == null) {
      return false;
    }

    final result = await externalSource.findProduct(unknownProduct.name);

    if (result == null) {
      return false;
    }

    final existing = await database.getFoodProductByNameOrAlias(result.name);

    final int foodProductId;

    if (existing != null) {
      foodProductId = existing.id;
    } else {
      foodProductId = await database.addFoodProduct(
        name: result.name,
        state: result.state,
        category: result.category,
        source: result.source,
        sourceId: result.sourceId,
        caloriesPer100g: result.caloriesPer100g,
        proteinPer100g: result.proteinPer100g,
        fatPer100g: result.fatPer100g,
        carbsPer100g: result.carbsPer100g,
        gramsPerMl: result.gramsPerMl,
      );
    }

    await database.addFoodProductAlias(
      foodProductId: foodProductId,
      alias: unknownProduct.name,
    );

    await database.markUnknownFoodProductResolved(
      unknownFoodProductId: unknownProduct.id,
      foodProductId: foodProductId,
    );

    return true;
  }

  Future<void> resolvePendingProducts() async {
    final pendingProducts = await getPendingProducts();

    for (final product in pendingProducts) {
      final resolvedLocally = await resolveFromLocalCatalog(product);

      if (resolvedLocally) {
        continue;
      }

      await resolveFromExternalSource(product);
    }
  }
}

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

  Future<void> resolvePendingProducts() async {
    final pendingProducts = await getPendingProducts();

    for (final product in pendingProducts) {
      await resolveFromLocalCatalog(product);
    }
  }
}

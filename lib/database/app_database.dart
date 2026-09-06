import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Families extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  DateTimeColumn get createdAt => dateTime()();
}

class FamilyMembers extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get familyId => integer()();

  TextColumn get name => text()();

  DateTimeColumn get birthDate => dateTime().nullable()();

  TextColumn get gender => text().nullable()();

  RealColumn get heightCm => real().nullable()();

  RealColumn get weightKg => real().nullable()();

  TextColumn get goal => text().nullable()();

  TextColumn get activity => text().nullable()();

  TextColumn get dietType => text().nullable()();

  TextColumn get allergies => text().nullable()();

  TextColumn get intolerances => text().nullable()();

  TextColumn get dislikedFoods => text().nullable()();

  TextColumn get likedFoods => text().nullable()();

  TextColumn get preferences => text().nullable()();
}

class PantryProducts extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get familyId => integer()();

  TextColumn get name => text()();

  TextColumn get amount => text()();

  TextColumn get unit => text()();

  RealColumn get weightGrams => real().nullable()();
  DateTimeColumn get expirationDate => dateTime().nullable()();
}

class FoodProducts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();

  TextColumn get state => text()();

  TextColumn get category => text().withDefault(const Constant(''))();

  RealColumn get caloriesPer100g => real()();

  RealColumn get proteinPer100g => real()();

  RealColumn get fatPer100g => real()();

  RealColumn get carbsPer100g => real()();

  RealColumn get gramsPerMl => real().nullable()();
}

class Recipes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get instructions => text().withDefault(const Constant(''))();

  IntColumn get prepMinutes => integer().nullable()();
  IntColumn get servings => integer().withDefault(const Constant(1))();

  RealColumn get caloriesPerServing => real()();

  RealColumn get proteinPerServing => real()();

  RealColumn get fatPerServing => real()();

  RealColumn get carbsPerServing => real()();

  TextColumn get dietTypes => text().nullable()();

  TextColumn get allergens => text().nullable()();

  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(false))();
}

class RecipeIngredients extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get recipeId => integer()();

  TextColumn get name => text()();

  RealColumn get amount => real()();

  TextColumn get unit => text()();

  RealColumn get weightGrams => real().nullable()();
  RealColumn get caloriesPer100g => real().nullable()();

  RealColumn get proteinPer100g => real().nullable()();

  RealColumn get fatPer100g => real().nullable()();

  RealColumn get carbsPer100g => real().nullable()();
}

@DriftDatabase(
  tables: [
    Families,
    FamilyMembers,
    PantryProducts,
    FoodProducts,
    Recipes,
    RecipeIngredients,
  ],
)
class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;

  factory AppDatabase() {
    return _instance ??= AppDatabase._internal();
  }

  AppDatabase._internal() : super(_openConnection());

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(families);
        await m.createTable(familyMembers);
        await m.addColumn(pantryProducts, pantryProducts.familyId);
      }

      if (from < 3) {
        await m.addColumn(familyMembers, familyMembers.birthDate);
        await m.addColumn(familyMembers, familyMembers.gender);
        await m.addColumn(familyMembers, familyMembers.heightCm);
        await m.addColumn(familyMembers, familyMembers.weightKg);
        await m.addColumn(familyMembers, familyMembers.goal);
        await m.addColumn(familyMembers, familyMembers.activity);
        await m.addColumn(familyMembers, familyMembers.dietType);
        await m.addColumn(familyMembers, familyMembers.allergies);
        await m.addColumn(familyMembers, familyMembers.intolerances);
        await m.addColumn(familyMembers, familyMembers.dislikedFoods);
        await m.addColumn(familyMembers, familyMembers.likedFoods);
        await m.addColumn(familyMembers, familyMembers.preferences);
      }
      if (from < 4) {
        await m.createTable(recipes);
        await m.createTable(recipeIngredients);
      }
      if (from < 5) {
        await m.addColumn(recipes, recipes.instructions);
        await m.addColumn(recipes, recipes.prepMinutes);
      }
      if (from < 6) {
        await m.addColumn(recipeIngredients, recipeIngredients.caloriesPer100g);
        await m.addColumn(recipeIngredients, recipeIngredients.proteinPer100g);
        await m.addColumn(recipeIngredients, recipeIngredients.fatPer100g);
        await m.addColumn(recipeIngredients, recipeIngredients.carbsPer100g);
      }

      if (from < 8) {
        await m.addColumn(recipeIngredients, recipeIngredients.weightGrams);
      }

      if (from < 9) {
        await m.createTable(foodProducts);
      }

      if (from < 10) {
        await m.addColumn(foodProducts, foodProducts.category);
      }
    },
  );

  Future<List<FoodProduct>> getAllFoodProducts() {
    return select(foodProducts).get();
  }

  Future<FoodProduct?> getFoodProductByName(String name) {
    return (select(
      foodProducts,
    )..where((table) => table.name.equals(name))).getSingleOrNull();
  }

  Future<int> addFoodProduct({
    required String name,
    required String state,
    required String category,
    required double caloriesPer100g,
    required double proteinPer100g,
    required double fatPer100g,
    required double carbsPer100g,
    double? gramsPerMl,
  }) {
    return into(foodProducts).insert(
      FoodProductsCompanion.insert(
        name: name,
        state: state,
        category: Value(category),
        caloriesPer100g: caloriesPer100g,
        proteinPer100g: proteinPer100g,
        fatPer100g: fatPer100g,
        carbsPer100g: carbsPer100g,
        gramsPerMl: Value(gramsPerMl),
      ),
    );
  }

  Future<int> updateFoodProductCategory({
    required int id,
    required String category,
  }) {
    return (update(foodProducts)..where((table) => table.id.equals(id))).write(
      FoodProductsCompanion(
        category: Value(category),
      ),
    );
  }

  Future<List<Family>> getAllFamilies() {
    return select(families).get();
  }

  Future<Family?> getFirstFamily() async {
    final result =
        await (select(families)
              ..orderBy([
                (table) =>
                    OrderingTerm(expression: table.id, mode: OrderingMode.asc),
              ])
              ..limit(1))
            .get();

    return result.isEmpty ? null : result.first;
  }

  Future<int> createFamily(String name) {
    return into(
      families,
    ).insert(FamiliesCompanion.insert(name: name, createdAt: DateTime.now()));
  }

  Future<int> addFamilyMember({required int familyId, required String name}) {
    return into(familyMembers)
        .insert(FamilyMembersCompanion.insert(familyId: familyId, name: name));
  }

  Future<List<FamilyMember>> getFamilyMembers(int familyId) {
    return (select(familyMembers)
          ..where((table) => table.familyId.equals(familyId))
          ..orderBy([
            (table) =>
                OrderingTerm(expression: table.id, mode: OrderingMode.asc),
          ]))
        .get();
  }

  Future<FamilyMember?> getFamilyMember(int id) {
    return (select(
      familyMembers,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Future<bool> updateFamilyMember({
    required int id,
    required String name,
    DateTime? birthDate,
    String? gender,
    double? heightCm,
    double? weightKg,
    String? goal,
    String? activity,
    String? dietType,
    String? allergies,
    String? intolerances,
    String? dislikedFoods,
    String? likedFoods,
    String? preferences,
  }) async {
    final changedRows =
        await (update(
          familyMembers,
        )..where((table) => table.id.equals(id))).write(
          FamilyMembersCompanion(
            name: Value(name),
            birthDate: birthDate != null
                ? Value(birthDate)
                : const Value.absent(),
            gender: gender != null ? Value(gender) : const Value.absent(),
            heightCm: heightCm != null ? Value(heightCm) : const Value.absent(),
            weightKg: weightKg != null ? Value(weightKg) : const Value.absent(),
            goal: goal != null ? Value(goal) : const Value.absent(),
            activity: activity != null ? Value(activity) : const Value.absent(),
            dietType: dietType != null ? Value(dietType) : const Value.absent(),
            allergies: allergies != null
                ? Value(allergies)
                : const Value.absent(),
            intolerances: intolerances != null
                ? Value(intolerances)
                : const Value.absent(),
            dislikedFoods: dislikedFoods != null
                ? Value(dislikedFoods)
                : const Value.absent(),
            likedFoods: likedFoods != null
                ? Value(likedFoods)
                : const Value.absent(),
            preferences: preferences != null
                ? Value(preferences)
                : const Value.absent(),
          ),
        );

    return changedRows > 0;
  }

  Future<int> deleteFamilyMember(int id) {
    return (delete(familyMembers)..where((table) => table.id.equals(id))).go();
  }

  Future<List<PantryProduct>> getAllProducts(int familyId) {
    return (select(
      pantryProducts,
    )..where((table) => table.familyId.equals(familyId))).get();
  }

  Future<int> addProduct({
    required int familyId,
    required String name,
    required String amount,
    required String unit,
    DateTime? expirationDate,
  }) {
    return into(pantryProducts).insert(
      PantryProductsCompanion.insert(
        familyId: familyId,
        name: name,
        amount: amount,
        unit: unit,
        expirationDate: Value(expirationDate),
      ),
    );
  }

  Future<int> deleteProduct(int id) {
    return (delete(pantryProducts)..where((table) => table.id.equals(id))).go();
  }

  Future<int> addRecipe({
    required String name,
    String description = '',
    String instructions = '',
    int? prepMinutes,
    int servings = 1,
    required double caloriesPerServing,
    required double proteinPerServing,
    required double fatPerServing,
    required double carbsPerServing,
    String? dietTypes,
    String? allergens,
    bool isBuiltIn = false,
  }) {
    return into(recipes).insert(
      RecipesCompanion.insert(
        name: name,
        description: Value(description),
        instructions: Value(instructions),
        prepMinutes: Value(prepMinutes),
        servings: Value(servings),
        caloriesPerServing: caloriesPerServing,
        proteinPerServing: proteinPerServing,
        fatPerServing: fatPerServing,
        carbsPerServing: carbsPerServing,
        dietTypes: Value(dietTypes),
        allergens: Value(allergens),
        isBuiltIn: Value(isBuiltIn),
      ),
    );
  }

  Future<int> addRecipeIngredient({
    required int recipeId,
    required String name,
    required double amount,
    required String unit,
    double? weightGrams,
    double? caloriesPer100g,
    double? proteinPer100g,
    double? fatPer100g,
    double? carbsPer100g,
  }) {
    return into(recipeIngredients).insert(
      RecipeIngredientsCompanion.insert(
        recipeId: recipeId,
        name: name,
        amount: amount,
        unit: unit,
        weightGrams: Value(weightGrams),
        caloriesPer100g: Value(caloriesPer100g),
        proteinPer100g: Value(proteinPer100g),
        fatPer100g: Value(fatPer100g),
        carbsPer100g: Value(carbsPer100g),
      ),
    );
  }

  Future<int> updateRecipeDetails({
    required int id,
    required String description,
    required String instructions,
    int? prepMinutes,
    String? dietTypes,
    String? allergens,
  }) {
    return (update(recipes)..where((table) => table.id.equals(id))).write(
      RecipesCompanion(
        description: Value(description),
        instructions: Value(instructions),
        prepMinutes: Value(prepMinutes),
        dietTypes: Value(dietTypes),
        allergens: Value(allergens),
      ),
    );
  }

  Future<List<Recipe>> getAllRecipes() {
    return (select(recipes)..orderBy([
          (table) =>
              OrderingTerm(expression: table.name, mode: OrderingMode.asc),
        ]))
        .get();
  }

  Future<Recipe?> getRecipe(int id) {
    return (select(
      recipes,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Future<List<RecipeIngredient>> getRecipeIngredients(int recipeId) {
    return (select(recipeIngredients)
          ..where((table) => table.recipeId.equals(recipeId))
          ..orderBy([
            (table) =>
                OrderingTerm(expression: table.id, mode: OrderingMode.asc),
          ]))
        .get();
  }

  Future<int> updateRecipeIngredientNutrition({
    required int id,
    double? weightGrams,
    double? caloriesPer100g,
    double? proteinPer100g,
    double? fatPer100g,
    double? carbsPer100g,
  }) {
    return (update(
      recipeIngredients,
    )..where((table) => table.id.equals(id))).write(
      RecipeIngredientsCompanion(
        weightGrams: Value(weightGrams),
        caloriesPer100g: Value(caloriesPer100g),
        proteinPer100g: Value(proteinPer100g),
        fatPer100g: Value(fatPer100g),
        carbsPer100g: Value(carbsPer100g),
      ),
    );
  }

  Future<int> deleteRecipeIngredients(int recipeId) {
    return (delete(
      recipeIngredients,
    )..where((table) => table.recipeId.equals(recipeId))).go();
  }

  Future<int> deleteRecipe(int id) async {
    await (delete(
      recipeIngredients,
    )..where((table) => table.recipeId.equals(id))).go();

    return (delete(recipes)..where((table) => table.id.equals(id))).go();
  }

  Future<int> getRecipeCount() async {
    final countExpression = recipes.id.count();

    final query = selectOnly(recipes)..addColumns([countExpression]);

    final row = await query.getSingle();

    return row.read(countExpression) ?? 0;
  }
}

DatabaseConnection _openConnection() {
  return driftDatabase(
    name: 'family_meal_ai',
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}

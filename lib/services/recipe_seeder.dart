import '../database/app_database.dart';

class RecipeSeeder {
  static Future<void> _fillMissingIngredientNutrition(
    AppDatabase database,
  ) async {
    final recipes = await database.getAllRecipes();

    for (final recipe in recipes) {
      final ingredients = await database.getRecipeIngredients(recipe.id);

      for (final ingredient in ingredients) {
        final nutrition = await database.getFoodProductByName(ingredient.name);

        if (nutrition == null) {
          continue;
        }
        final gramsPerMl = nutrition.gramsPerMl;

        double? weightGrams = ingredient.weightGrams;

        if (weightGrams == null) {
          if (ingredient.unit == 'г') {
            weightGrams = ingredient.amount;
          } else if (ingredient.unit == 'мл' && gramsPerMl != null) {
            weightGrams = ingredient.amount * gramsPerMl;
          }
        }

        final alreadyComplete =
            weightGrams != null &&
            ingredient.caloriesPer100g != null &&
            ingredient.proteinPer100g != null &&
            ingredient.fatPer100g != null &&
            ingredient.carbsPer100g != null;

        if (alreadyComplete) {
          continue;
        }

        await database.updateRecipeIngredientNutrition(
          id: ingredient.id,
          weightGrams: weightGrams,
          caloriesPer100g:
              ingredient.caloriesPer100g ?? nutrition.caloriesPer100g,
          proteinPer100g: ingredient.proteinPer100g ?? nutrition.proteinPer100g,
          fatPer100g: ingredient.fatPer100g ?? nutrition.fatPer100g,
          carbsPer100g: ingredient.carbsPer100g ?? nutrition.carbsPer100g,
        );
      }
    }
  }

  static Future<void> seedIfNeeded(AppDatabase database) async {
    await _fillMissingIngredientNutrition(database);

    final recipes = await database.getAllRecipes();

    if (recipes.isEmpty) {
      await _addChickenRice(database);
      await _addSalmonPotatoes(database);
      await _addBeefPasta(database);
      await _addTurkeyCouscous(database);
      await _addLentilStew(database);
      await _addChickenVegetables(database);
      await _addFishRice(database);
      await _addBeefBuckwheat(database);
      await _addVegetablePasta(database);
      await _addChickenPotatoes(database);
      return;
    }

    for (final recipe in recipes) {
      switch (recipe.name) {
        case 'Курица с рисом и овощами':
          await database.updateRecipeDetails(
            id: recipe.id,
            description: 'Нежная куриная грудка с рисом, морковью и кабачком. Простое сбалансированное семейное блюдо.',
            instructions: '''
1. Рис тщательно промойте под холодной водой.
2. Залейте рис водой и приготовьте до готовности согласно инструкции на упаковке.
3. Куриную грудку нарежьте небольшими кусочками.
4. Морковь нарежьте тонкими ломтиками, кабачок — кубиками.
5. Разогрейте половину оливкового масла на большой сковороде.
6. Обжарьте курицу на среднем огне 7–10 минут до полной готовности.
7. Переложите курицу на тарелку.
8. Добавьте оставшееся масло, морковь и кабачок.
9. Готовьте овощи 6–8 минут, периодически помешивая.
10. Верните курицу в сковороду, перемешайте и прогрейте ещё 2–3 минуты.
11. Подавайте курицу с овощами вместе с готовым рисом.
''',
            prepMinutes: 35,
            dietTypes: 'omnivore,high_protein',
            allergens: '',
          );
          break;

        case 'Лосось с картофелем':
          await database.updateRecipeDetails(
            id: recipe.id,
            description: 'Запечённое филе лосося с картофелем и брокколи — сытный семейный ужин с рыбой и овощами.',
            instructions: '''
1. Разогрейте духовку до 200 °C.
2. Картофель очистите или хорошо вымойте и нарежьте дольками.
3. Выложите картофель на противень, добавьте часть оливкового масла и перемешайте.
4. Запекайте картофель около 20 минут.
5. Разделите брокколи на небольшие соцветия.
6. Достаньте противень и добавьте филе лосося и брокколи.
7. Смажьте лосось и овощи оставшимся оливковым маслом.
8. Запекайте ещё 15–18 минут, пока лосось полностью не приготовится.
9. Проверьте готовность картофеля — он должен легко прокалываться вилкой.
10. Разделите блюдо на порции и подавайте горячим.
''',
            prepMinutes: 45,
            dietTypes: 'omnivore,pescatarian,mediterranean',
            allergens: 'Рыба',
          );
          break;

        case 'Паста с говядиной':
          await database.updateRecipeDetails(
            id: recipe.id,
            description: 'Паста с обжаренной говядиной, луком и насыщенным томатным соусом.',
            instructions: '''
1. Вскипятите большую кастрюлю воды.
2. Отварите пасту до состояния al dente согласно инструкции на упаковке.
3. Лук мелко нарежьте.
4. Говядину нарежьте небольшими кусочками или используйте фарш.
5. Разогрейте оливковое масло на глубокой сковороде.
6. Обжарьте лук 3–4 минуты до мягкости.
7. Добавьте говядину и готовьте 7–10 минут, разбивая крупные кусочки.
8. Влейте томатный соус и перемешайте.
9. Уменьшите огонь и тушите 8–10 минут.
10. Добавьте готовую пасту в соус и хорошо перемешайте.
11. Прогрейте всё вместе ещё 1–2 минуты и подавайте.
''',
            prepMinutes: 35,
            dietTypes: 'omnivore',
            allergens: 'Пшеница',
          );
          break;

        case 'Индейка с кускусом':
          await database.updateRecipeDetails(
            id: recipe.id,
            description:
                'Нежное филе индейки с кускусом, сладким перцем и кабачком.',
            instructions: '''
1. Нарежьте индейку небольшими кусочками.
2. Перец и кабачок нарежьте кубиками.
3. Разогрейте половину оливкового масла на большой сковороде.
4. Обжарьте индейку 7–9 минут до полной готовности.
5. Переложите индейку на тарелку.
6. Добавьте оставшееся масло, перец и кабачок.
7. Готовьте овощи 6–7 минут.
8. Приготовьте кускус согласно инструкции на упаковке.
9. Верните индейку к овощам и перемешайте.
10. Прогрейте ещё 2 минуты.
11. Подавайте индейку с овощами поверх кускуса или рядом с ним.
''',
            prepMinutes: 30,
            dietTypes: 'omnivore,high_protein',
            allergens: 'Пшеница',
          );
          break;

        case 'Чечевичное рагу':
          await database.updateRecipeDetails(
            id: recipe.id,
            description:
                'Густое овощное рагу с чечевицей, томатами, морковью и луком.',
            instructions: '''
1. Чечевицу промойте под проточной водой.
2. Лук мелко нарежьте, морковь нарежьте небольшими кубиками.
3. Разогрейте оливковое масло в глубокой кастрюле.
4. Обжарьте лук 3–4 минуты.
5. Добавьте морковь и готовьте ещё 5 минут.
6. Добавьте томаты и чечевицу.
7. Влейте воду так, чтобы она покрывала чечевицу примерно на 2–3 см.
8. Доведите до кипения.
9. Уменьшите огонь и готовьте под крышкой 25–30 минут.
10. Периодически помешивайте и при необходимости добавляйте немного воды.
11. Когда чечевица станет мягкой, снимите рагу с огня.
12. Дайте постоять 5 минут перед подачей.
''',
            prepMinutes: 45,
            dietTypes: 'vegan,vegetarian,mediterranean',
            allergens: '',
          );
          break;

        case 'Курица с овощами':
          await database.updateRecipeDetails(
            id: recipe.id,
            description: 'Запечённое куриное филе с кабачком, баклажаном и сладким перцем.',
            instructions: '''
1. Разогрейте духовку до 200 °C.
2. Куриное филе нарежьте крупными кусочками.
3. Кабачок, баклажан и перец нарежьте примерно одинаковыми кусочками.
4. Сложите курицу и овощи в большую миску.
5. Добавьте оливковое масло и хорошо перемешайте.
6. Выложите всё одним слоем на противень.
7. Запекайте 25–30 минут.
8. В середине приготовления один раз перемешайте овощи.
9. Проверьте, чтобы курица была полностью приготовлена.
10. Подавайте блюдо горячим.
''',
            prepMinutes: 40,
            dietTypes: 'omnivore,high_protein,keto',
            allergens: '',
          );
          break;

        case 'Белая рыба с рисом':
          await database.updateRecipeDetails(
            id: recipe.id,
            description: 'Нежное филе белой рыбы с рисом, брокколи и морковью.',
            instructions: '''
1. Рис хорошо промойте и приготовьте до готовности.
2. Морковь нарежьте тонкими полосками или ломтиками.
3. Брокколи разделите на небольшие соцветия.
4. Разогрейте духовку до 190 °C.
5. Выложите рыбу в форму для запекания.
6. Смажьте рыбу частью оливкового масла.
7. Запекайте 15–20 минут в зависимости от толщины филе.
8. Оставшееся масло разогрейте на сковороде.
9. Добавьте морковь и брокколи и готовьте 6–8 минут.
10. Подавайте готовую рыбу с рисом и овощами.
''',
            prepMinutes: 35,
            dietTypes: 'omnivore,pescatarian',
            allergens: 'Рыба',
          );
          break;

        case 'Говядина с гречкой':
          await database.updateRecipeDetails(
            id: recipe.id,
            description: 'Говядина с рассыпчатой гречкой, морковью и луком.',
            instructions: '''
1. Гречку промойте и отварите до готовности.
2. Говядину нарежьте небольшими тонкими кусочками.
3. Лук мелко нарежьте, морковь натрите или нарежьте соломкой.
4. Разогрейте оливковое масло на глубокой сковороде.
5. Обжарьте говядину 8–10 минут.
6. Добавьте лук и морковь.
7. Готовьте ещё 6–8 минут, периодически помешивая.
8. При необходимости добавьте небольшое количество воды.
9. Накройте крышкой и тушите ещё 10–15 минут, пока мясо не станет мягким.
10. Подавайте говядину с готовой гречкой.
''',
            prepMinutes: 45,
            dietTypes: 'omnivore,high_protein',
            allergens: '',
          );
          break;

        case 'Паста с овощами':
          await database.updateRecipeDetails(
            id: recipe.id,
            description: 'Лёгкая паста с томатами, кабачком, оливковым маслом и пармезаном.',
            instructions: '''
1. Вскипятите воду и отварите пасту до состояния al dente.
2. Кабачок нарежьте небольшими кубиками.
3. Томаты нарежьте кусочками.
4. Разогрейте оливковое масло на большой сковороде.
5. Добавьте кабачок и готовьте 5–6 минут.
6. Добавьте томаты и тушите ещё 6–8 минут.
7. Переложите готовую пасту в сковороду.
8. Хорошо перемешайте пасту с овощами.
9. При необходимости добавьте немного воды от варки пасты.
10. Снимите с огня.
11. Добавьте тёртый пармезан и перемешайте.
12. Подавайте сразу.
''',
            prepMinutes: 30,
            dietTypes: 'vegetarian,mediterranean',
            allergens: 'Пшеница,Молоко',
          );
          break;

        case 'Курица с картофелем':
          await database.updateRecipeDetails(
            id: recipe.id,
            description: 'Запечённая курица с картофелем, морковью и луком — простой семейный ужин.',
            instructions: '''
1. Разогрейте духовку до 200 °C.
2. Картофель нарежьте средними дольками.
3. Морковь нарежьте кружочками, лук — крупными кусочками.
4. Курицу нарежьте порционными кусками, если это необходимо.
5. Сложите курицу, картофель, морковь и лук в большую форму.
6. Добавьте оливковое масло и хорошо перемешайте.
7. Распределите ингредиенты равномерным слоем.
8. Запекайте 40–50 минут.
9. Через 25 минут аккуратно перемешайте овощи.
10. Проверьте готовность курицы и картофеля.
11. Перед подачей дайте блюду постоять около 5 минут.
''',
            prepMinutes: 60,
            dietTypes: 'omnivore',
            allergens: '',
          );
          break;
      }
    }
  }

  static Future<void> _addChickenRice(AppDatabase database) async {
    final recipeId = await database.addRecipe(
      name: 'Курица с рисом и овощами',
      description: 'Нежная куриная грудка с рисом, морковью и кабачком. Простое сбалансированное семейное блюдо.',
      instructions: '''
1. Рис тщательно промойте под холодной водой.
2. Залейте рис водой и приготовьте до готовности согласно инструкции на упаковке.
3. Куриную грудку нарежьте небольшими кусочками.
4. Морковь нарежьте тонкими ломтиками, кабачок — кубиками.
5. Разогрейте половину оливкового масла на большой сковороде.
6. Обжарьте курицу на среднем огне 7–10 минут до полной готовности.
7. Переложите курицу на тарелку.
8. Добавьте оставшееся масло, морковь и кабачок.
9. Готовьте овощи 6–8 минут, периодически помешивая.
10. Верните курицу в сковороду, перемешайте и прогрейте ещё 2–3 минуты.
11. Подавайте курицу с овощами вместе с готовым рисом.
''',
      prepMinutes: 35,
      servings: 4,
      caloriesPerServing: 520,
      proteinPerServing: 38,
      fatPerServing: 14,
      carbsPerServing: 58,
      dietTypes: 'omnivore,high_protein',
      allergens: '',
      isBuiltIn: true,
    );

    await _addIngredients(database, recipeId, [
      ('Куриная грудка', 600.0, 'г'),
      ('Рис', 300.0, 'г'),
      ('Морковь', 150.0, 'г'),
      ('Кабачок', 200.0, 'г'),
      ('Оливковое масло', 30.0, 'мл'),
    ]);
  }

  static Future<void> _addSalmonPotatoes(AppDatabase database) async {
    final recipeId = await database.addRecipe(
      name: 'Лосось с картофелем',
      description: 'Запечённое филе лосося с картофелем и брокколи — сытный семейный ужин с рыбой и овощами.',
      instructions: '''
1. Разогрейте духовку до 200 °C.
2. Картофель нарежьте дольками.
3. Выложите картофель на противень и добавьте часть масла.
4. Запекайте около 20 минут.
5. Добавьте лосось и брокколи.
6. Смажьте оставшимся маслом.
7. Запекайте ещё 15–18 минут.
8. Проверьте готовность рыбы и картофеля.
9. Разделите на порции и подавайте.
''',
      prepMinutes: 45,
      servings: 4,
      caloriesPerServing: 610,
      proteinPerServing: 36,
      fatPerServing: 28,
      carbsPerServing: 50,
      dietTypes: 'omnivore,pescatarian,mediterranean',
      allergens: 'Рыба',
      isBuiltIn: true,
    );

    await _addIngredients(database, recipeId, [
      ('Лосось', 600.0, 'г'),
      ('Картофель', 800.0, 'г'),
      ('Брокколи', 300.0, 'г'),
      ('Оливковое масло', 30.0, 'мл'),
    ]);
  }

  static Future<void> _addBeefPasta(AppDatabase database) async {
    final recipeId = await database.addRecipe(
      name: 'Паста с говядиной',
      description:
          'Паста с обжаренной говядиной, луком и насыщенным томатным соусом.',
      instructions: '''
1. Отварите пасту до состояния al dente.
2. Мелко нарежьте лук.
3. Разогрейте масло и обжарьте лук.
4. Добавьте говядину и готовьте 7–10 минут.
5. Добавьте томатный соус.
6. Тушите около 10 минут.
7. Добавьте пасту.
8. Перемешайте и прогрейте 1–2 минуты.
''',
      prepMinutes: 35,
      servings: 4,
      caloriesPerServing: 640,
      proteinPerServing: 35,
      fatPerServing: 20,
      carbsPerServing: 72,
      dietTypes: 'omnivore',
      allergens: 'Пшеница',
      isBuiltIn: true,
    );

    await _addIngredients(database, recipeId, [
      ('Говядина', 500.0, 'г'),
      ('Паста', 350.0, 'г'),
      ('Томатный соус', 400.0, 'г'),
      ('Лук', 120.0, 'г'),
      ('Оливковое масло', 20.0, 'мл'),
    ]);
  }

  static Future<void> _addTurkeyCouscous(AppDatabase database) async {
    final recipeId = await database.addRecipe(
      name: 'Индейка с кускусом',
      description: 'Нежное филе индейки с кускусом, сладким перцем и кабачком.',
      instructions: '''
1. Нарежьте индейку и овощи.
2. Обжарьте индейку до полной готовности.
3. Переложите индейку на тарелку.
4. Обжарьте перец и кабачок.
5. Приготовьте кускус согласно инструкции.
6. Верните индейку к овощам.
7. Перемешайте и прогрейте.
8. Подавайте вместе с кускусом.
''',
      prepMinutes: 30,
      servings: 4,
      caloriesPerServing: 540,
      proteinPerServing: 40,
      fatPerServing: 14,
      carbsPerServing: 60,
      dietTypes: 'omnivore,high_protein',
      allergens: 'Пшеница',
      isBuiltIn: true,
    );

    await _addIngredients(database, recipeId, [
      ('Филе индейки', 600.0, 'г'),
      ('Кускус', 300.0, 'г'),
      ('Перец', 200.0, 'г'),
      ('Кабачок', 200.0, 'г'),
      ('Оливковое масло', 25.0, 'мл'),
    ]);
  }

  static Future<void> _addLentilStew(AppDatabase database) async {
    final recipeId = await database.addRecipe(
      name: 'Чечевичное рагу',
      description:
          'Густое овощное рагу с чечевицей, томатами, морковью и луком.',
      instructions: '''
1. Промойте чечевицу.
2. Нарежьте лук и морковь.
3. Обжарьте лук на масле.
4. Добавьте морковь и готовьте 5 минут.
5. Добавьте томаты и чечевицу.
6. Залейте водой.
7. Доведите до кипения.
8. Готовьте под крышкой 25–30 минут.
9. При необходимости добавляйте воду.
10. Дайте рагу постоять 5 минут.
''',
      prepMinutes: 45,
      servings: 4,
      caloriesPerServing: 430,
      proteinPerServing: 22,
      fatPerServing: 10,
      carbsPerServing: 58,
      dietTypes: 'vegan,vegetarian,mediterranean',
      allergens: '',
      isBuiltIn: true,
    );

    await _addIngredients(database, recipeId, [
      ('Чечевица', 350.0, 'г'),
      ('Морковь', 180.0, 'г'),
      ('Томаты', 400.0, 'г'),
      ('Лук', 120.0, 'г'),
      ('Оливковое масло', 25.0, 'мл'),
    ]);
  }

  static Future<void> _addChickenVegetables(AppDatabase database) async {
    final recipeId = await database.addRecipe(
      name: 'Курица с овощами',
      description:
          'Запечённое куриное филе с кабачком, баклажаном и сладким перцем.',
      instructions: '''
1. Разогрейте духовку до 200 °C.
2. Нарежьте курицу и овощи.
3. Смешайте всё с оливковым маслом.
4. Выложите на противень.
5. Запекайте 25–30 минут.
6. В середине приготовления перемешайте.
7. Проверьте готовность курицы.
8. Подавайте горячим.
''',
      prepMinutes: 40,
      servings: 4,
      caloriesPerServing: 460,
      proteinPerServing: 42,
      fatPerServing: 22,
      carbsPerServing: 24,
      dietTypes: 'omnivore,high_protein,keto',
      allergens: '',
      isBuiltIn: true,
    );

    await _addIngredients(database, recipeId, [
      ('Куриное филе', 650.0, 'г'),
      ('Кабачок', 250.0, 'г'),
      ('Баклажан', 250.0, 'г'),
      ('Перец', 200.0, 'г'),
      ('Оливковое масло', 35.0, 'мл'),
    ]);
  }

  static Future<void> _addFishRice(AppDatabase database) async {
    final recipeId = await database.addRecipe(
      name: 'Белая рыба с рисом',
      description: 'Нежное филе белой рыбы с рисом, брокколи и морковью.',
      instructions: '''
1. Приготовьте рис.
2. Нарежьте морковь и разделите брокколи на соцветия.
3. Разогрейте духовку до 190 °C.
4. Выложите рыбу в форму.
5. Смажьте частью масла.
6. Запекайте 15–20 минут.
7. Обжарьте морковь и брокколи на оставшемся масле.
8. Подавайте рыбу с рисом и овощами.
''',
      prepMinutes: 35,
      servings: 4,
      caloriesPerServing: 500,
      proteinPerServing: 37,
      fatPerServing: 12,
      carbsPerServing: 58,
      dietTypes: 'omnivore,pescatarian',
      allergens: 'Рыба',
      isBuiltIn: true,
    );

    await _addIngredients(database, recipeId, [
      ('Филе белой рыбы', 650.0, 'г'),
      ('Рис', 300.0, 'г'),
      ('Морковь', 150.0, 'г'),
      ('Брокколи', 250.0, 'г'),
      ('Оливковое масло', 20.0, 'мл'),
    ]);
  }

  static Future<void> _addBeefBuckwheat(AppDatabase database) async {
    final recipeId = await database.addRecipe(
      name: 'Говядина с гречкой',
      description: 'Говядина с рассыпчатой гречкой, морковью и луком.',
      instructions: '''
1. Отварите гречку.
2. Нарежьте говядину.
3. Нарежьте лук и морковь.
4. Обжарьте говядину 8–10 минут.
5. Добавьте овощи.
6. Готовьте ещё 6–8 минут.
7. Добавьте немного воды.
8. Тушите под крышкой 10–15 минут.
9. Подавайте с гречкой.
''',
      prepMinutes: 45,
      servings: 4,
      caloriesPerServing: 590,
      proteinPerServing: 38,
      fatPerServing: 22,
      carbsPerServing: 56,
      dietTypes: 'omnivore,high_protein',
      allergens: '',
      isBuiltIn: true,
    );

    await _addIngredients(database, recipeId, [
      ('Говядина', 550.0, 'г'),
      ('Гречка', 300.0, 'г'),
      ('Морковь', 150.0, 'г'),
      ('Лук', 120.0, 'г'),
      ('Оливковое масло', 25.0, 'мл'),
    ]);
  }

  static Future<void> _addVegetablePasta(AppDatabase database) async {
    final recipeId = await database.addRecipe(
      name: 'Паста с овощами',
      description:
          'Лёгкая паста с томатами, кабачком, оливковым маслом и пармезаном.',
      instructions: '''
1. Отварите пасту до состояния al dente.
2. Нарежьте кабачок и томаты.
3. Обжарьте кабачок на оливковом масле.
4. Добавьте томаты.
5. Тушите 6–8 минут.
6. Добавьте готовую пасту.
7. Перемешайте.
8. Добавьте немного воды от варки пасты при необходимости.
9. Снимите с огня.
10. Добавьте пармезан и подавайте.
''',
      prepMinutes: 30,
      servings: 4,
      caloriesPerServing: 470,
      proteinPerServing: 16,
      fatPerServing: 14,
      carbsPerServing: 68,
      dietTypes: 'vegetarian,mediterranean',
      allergens: 'Пшеница,Молоко',
      isBuiltIn: true,
    );

    await _addIngredients(database, recipeId, [
      ('Паста', 350.0, 'г'),
      ('Томаты', 400.0, 'г'),
      ('Кабачок', 250.0, 'г'),
      ('Оливковое масло', 30.0, 'мл'),
      ('Пармезан', 80.0, 'г'),
    ]);
  }

  static Future<void> _addChickenPotatoes(AppDatabase database) async {
    final recipeId = await database.addRecipe(
      name: 'Курица с картофелем',
      description: 'Запечённая курица с картофелем, морковью и луком — простой семейный ужин.',
      instructions: '''
1. Разогрейте духовку до 200 °C.
2. Нарежьте картофель, морковь и лук.
3. Подготовьте курицу.
4. Сложите всё в форму для запекания.
5. Добавьте оливковое масло и перемешайте.
6. Запекайте 40–50 минут.
7. Через 25 минут перемешайте овощи.
8. Проверьте готовность курицы и картофеля.
9. Дайте блюду постоять 5 минут перед подачей.
''',
      prepMinutes: 60,
      servings: 4,
      caloriesPerServing: 570,
      proteinPerServing: 40,
      fatPerServing: 20,
      carbsPerServing: 55,
      dietTypes: 'omnivore',
      allergens: '',
      isBuiltIn: true,
    );

    await database.addRecipeIngredient(
      recipeId: recipeId,
      name: 'Курица',
      amount: 700.0,
      unit: 'г',
      weightGrams: 700.0,
      caloriesPer100g: 165,
      proteinPer100g: 31,
      fatPer100g: 3.6,
      carbsPer100g: 0,
    );

    await database.addRecipeIngredient(
      recipeId: recipeId,
      name: 'Картофель',
      amount: 800.0,
      unit: 'г',
      weightGrams: 800.0,
      caloriesPer100g: 77,
      proteinPer100g: 2.0,
      fatPer100g: 0.1,
      carbsPer100g: 17.5,
    );

    await database.addRecipeIngredient(
      recipeId: recipeId,
      name: 'Морковь',
      amount: 180.0,
      unit: 'г',
      weightGrams: 180.0,
      caloriesPer100g: 41,
      proteinPer100g: 0.9,
      fatPer100g: 0.2,
      carbsPer100g: 9.6,
    );

    await database.addRecipeIngredient(
      recipeId: recipeId,
      name: 'Лук',
      amount: 120.0,
      unit: 'г',
      weightGrams: 120.0,
      caloriesPer100g: 40,
      proteinPer100g: 1.1,
      fatPer100g: 0.1,
      carbsPer100g: 9.3,
    );

    await database.addRecipeIngredient(
      recipeId: recipeId,
      name: 'Оливковое масло',
      amount: 30.0,
      unit: 'мл',
      weightGrams: 27.3,
      caloriesPer100g: 884,
      proteinPer100g: 0,
      fatPer100g: 100,
      carbsPer100g: 0,
    );
  }

  static Future<void> _addIngredients(
    AppDatabase database,
    int recipeId,
    List<(String, double, String)> ingredients,
  ) async {
    for (final ingredient in ingredients) {
      final name = ingredient.$1;
      final amount = ingredient.$2;
      final unit = ingredient.$3;

      final nutrition = await database.getFoodProductByName(name);
      final gramsPerMl = nutrition?.gramsPerMl;

      double? weightGrams;

      if (unit == 'г') {
        weightGrams = amount;
      } else if (unit == 'мл' && gramsPerMl != null) {
        weightGrams = amount * gramsPerMl;
      }

      await database.addRecipeIngredient(
        recipeId: recipeId,
        name: name,
        amount: amount,
        unit: unit,
        weightGrams: weightGrams,
        caloriesPer100g: nutrition?.caloriesPer100g,
        proteinPer100g: nutrition?.proteinPer100g,
        fatPer100g: nutrition?.fatPer100g,
        carbsPer100g: nutrition?.carbsPer100g,
      );
    }
  }
}

import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../services/nutrition_calculator.dart';
import '../services/family_menu_planner.dart';
import 'recipes_screen.dart';

class FamilySummaryScreen extends StatefulWidget {
  final int familyId;
  final String familyName;

  const FamilySummaryScreen({
    super.key,
    required this.familyId,
    required this.familyName,
  });

  @override
  State<FamilySummaryScreen> createState() => _FamilySummaryScreenState();
}

class _FamilySummaryScreenState extends State<FamilySummaryScreen> {
  final AppDatabase _database = AppDatabase();

  List<FamilyMember> _members = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  Future<void> _loadMembers() async {
    final members = await _database.getFamilyMembers(widget.familyId);

    if (!mounted) {
      return;
    }

    setState(() {
      _members = members;
      _isLoading = false;
    });
  }

  String _goalText(String? goal) {
    switch (goal) {
      case 'weight_loss':
        return 'Снижение веса';
      case 'maintenance':
        return 'Поддержание веса';
      case 'weight_gain':
        return 'Набор веса';
      case 'muscle':
        return 'Мышцы и физическая форма';
      case 'healthy':
        return 'Здоровое питание';
      default:
        return 'Не указана';
    }
  }

  String _activityText(String? activity) {
    switch (activity) {
      case 'sedentary':
        return 'Минимальная';
      case 'light':
        return 'Лёгкая';
      case 'moderate':
        return 'Средняя';
      case 'high':
        return 'Высокая';
      case 'very_high':
        return 'Очень высокая';
      default:
        return 'Не указана';
    }
  }

  String _dietText(String? dietType) {
    switch (dietType) {
      case 'omnivore':
        return 'Обычное питание';
      case 'keto':
        return 'Кето';
      case 'paleo':
        return 'Палео';
      case 'high_protein':
        return 'Высокобелковое';
      case 'mediterranean':
        return 'Средиземноморское';
      case 'vegetarian':
        return 'Вегетарианское';
      case 'vegan':
        return 'Веганское';
      case 'pescatarian':
        return 'Пескетарианское';
      case 'kosher':
        return 'Кошерное';
      case 'halal':
        return 'Халяль';
      default:
        return 'Не указано';
    }
  }

  int? _age(DateTime? birthDate) {
    if (birthDate == null) {
      return null;
    }

    final today = DateTime.now();

    var age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  Widget _buildDinnerTargets(FamilyMember member) {
    final plan = FamilyMenuPlanner.createMealPlan(members: _members);

    final portion = plan.portions.firstWhere(
      (item) => item.memberId == member.id,
    );

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.dinner_dining, size: 20),
              SizedBox(width: 8),
              Text(
                'Цель на семейный ужин',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 18,
            runSpacing: 10,
            children: [
              _targetItem('Калории', '${portion.calories.round()} ккал'),
              _targetItem('Белки', '${portion.proteinGrams.round()} г'),
              _targetItem('Жиры', '${portion.fatGrams.round()} г'),
              _targetItem('Углеводы', '${portion.carbsGrams.round()} г'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionTargets(FamilyMember member) {
    try {
      final targets = NutritionCalculator.calculate(member);

      return Container(
        margin: const EdgeInsets.only(top: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Расчёт питания',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 18,
              runSpacing: 10,
              children: [
                _targetItem('Калории', '${targets.calories.round()} ккал'),
                _targetItem('Белки', '${targets.proteinGrams.round()} г'),
                _targetItem('Жиры', '${targets.fatGrams.round()} г'),
                _targetItem('Углеводы', '${targets.carbsGrams.round()} г'),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      return Container(
        margin: const EdgeInsets.only(top: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text('Расчёт пока недоступен: $e'),
      );
    }
  }

  Widget _targetItem(String label, String value) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.familyName)),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Семейный профиль',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Индивидуальные цели питания для каждого члена семьи.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _members.length,
                        itemBuilder: (context, index) {
                          final member = _members[index];
                          final age = _age(member.birthDate);

                          return Card(
                            margin: const EdgeInsets.only(bottom: 14),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    member.name,
                                    style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Возраст: ${age == null ? 'не указан' : '$age лет'}',
                                  ),
                                  Text('Цель: ${_goalText(member.goal)}'),
                                  Text(
                                    'Активность: ${_activityText(member.activity)}',
                                  ),
                                  Text(
                                    'Тип питания: ${_dietText(member.dietType)}',
                                  ),
                                  if (member.heightCm != null)
                                    Text(
                                      'Рост: ${member.heightCm!.round()} см',
                                    ),
                                  if (member.weightKg != null)
                                    Text(
                                      'Вес: ${member.weightKg!.toStringAsFixed(1)} кг',
                                    ),
                                  _buildNutritionTargets(member),
                                  _buildDinnerTargets(member),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RecipesScreen(familyId: widget.familyId),
                            ),
                          );
                        },
                        icon: const Icon(Icons.menu_book_outlined),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'Рецепты',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Следующий этап — создание общего семейного меню.',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.restaurant_menu),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'Создать семейное меню',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

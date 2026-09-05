import 'dart:convert';

import 'package:flutter/material.dart';

import '../database/app_database.dart' as db;
import '../models/family_member.dart';
import 'family_members_screen.dart';

class MemberFoodPreferencesScreen extends StatefulWidget {
  final FamilyMember member;
  final String goal;
  final String activity;

  const MemberFoodPreferencesScreen({
    super.key,
    required this.member,
    required this.goal,
    required this.activity,
  });

  @override
  State<MemberFoodPreferencesScreen> createState() =>
      _MemberFoodPreferencesScreenState();
}

class _MemberFoodPreferencesScreenState
    extends State<MemberFoodPreferencesScreen> {
  final db.AppDatabase _database = db.AppDatabase();

  String _dietType = 'omnivore';

  final Set<String> _allergies = {};
  final Set<String> _intolerances = {};
  final Set<String> _dislikedFoods = {};
  final Set<String> _likedFoods = {};

  final TextEditingController _customAllergyController =
      TextEditingController();
  final TextEditingController _customIntoleranceController =
      TextEditingController();
  final TextEditingController _customDislikeController =
      TextEditingController();
  final TextEditingController _customLikeController = TextEditingController();
  final TextEditingController _preferencesController = TextEditingController();

  bool _isLoading = true;
  bool _isSaving = false;

  final List<Map<String, String>> _dietTypes = [
    {'value': 'omnivore', 'title': 'Всеядный', 'icon': '🍽️'},
    {'value': 'keto', 'title': 'Кето', 'icon': '🥑'},
    {'value': 'paleo', 'title': 'Палео', 'icon': '🥩'},
    {'value': 'high_protein', 'title': 'Высокобелковый', 'icon': '💪'},
    {'value': 'mediterranean', 'title': 'Средиземноморский', 'icon': '🫒'},
    {'value': 'vegetarian', 'title': 'Вегетарианский', 'icon': '🥗'},
    {'value': 'vegan', 'title': 'Веганский', 'icon': '🌱'},
    {'value': 'pescatarian', 'title': 'Пескетарианский', 'icon': '🐟'},
    {'value': 'kosher', 'title': 'Кошерный', 'icon': '✡️'},
    {'value': 'halal', 'title': 'Халяль', 'icon': '☪️'},
  ];

  final List<String> _allergyOptions = [
    'Молоко',
    'Яйца',
    'Арахис',
    'Орехи',
    'Рыба',
    'Морепродукты',
    'Соя',
    'Кунжут',
    'Пшеница',
  ];

  final List<String> _intoleranceOptions = ['Лактоза', 'Глютен', 'Фруктоза'];

  final List<String> _foodOptions = [
    'Оливки',
    'Рыба',
    'Морепродукты',
    'Грибы',
    'Брокколи',
    'Цветная капуста',
    'Лук',
    'Чеснок',
    'Острые продукты',
    'Свинина',
    'Говядина',
    'Курица',
    'Яйца',
    'Сыр',
    'Молочные продукты',
    'Авокадо',
    'Сельдерей',
    'Кинза',
  ];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Set<String> _decodeSet(String? value) {
    if (value == null || value.trim().isEmpty) {
      return {};
    }

    try {
      final decoded = jsonDecode(value);

      if (decoded is List) {
        return decoded
            .whereType<String>()
            .where((item) => item.trim().isNotEmpty)
            .toSet();
      }
    } catch (_) {
      // Поддержка старых данных.
    }

    return value
        .split('|')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toSet();
  }

  String _encodeSet(Set<String> values) {
    final list = values.toList()..sort();
    return jsonEncode(list);
  }

  Future<void> _loadPreferences() async {
    try {
      final member = await _database.getFamilyMember(widget.member.id);

      if (!mounted) {
        return;
      }

      if (member != null) {
        setState(() {
          _dietType = member.dietType ?? 'omnivore';

          _allergies
            ..clear()
            ..addAll(_decodeSet(member.allergies));

          _intolerances
            ..clear()
            ..addAll(_decodeSet(member.intolerances));

          _dislikedFoods
            ..clear()
            ..addAll(_decodeSet(member.dislikedFoods));

          _likedFoods
            ..clear()
            ..addAll(_decodeSet(member.likedFoods));

          _preferencesController.text = member.preferences ?? '';
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось загрузить настройки питания: $e')),
      );
    }
  }

  void _addCustomFood({
    required TextEditingController controller,
    required Set<String> target,
  }) {
    final value = controller.text.trim();

    if (value.isEmpty) {
      return;
    }

    setState(() {
      target.add(value);
      controller.clear();
    });
  }

  Widget _buildChoiceSection({
    required String title,
    required String subtitle,
    required List<String> options,
    required Set<String> selected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: TextStyle(color: Colors.grey.shade700)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((item) {
            return FilterChip(
              label: Text(item),
              selected: selected.contains(item),
              onSelected: (value) {
                setState(() {
                  if (value) {
                    selected.add(item);
                  } else {
                    selected.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildCustomFoodInput({
    required String hint,
    required TextEditingController controller,
    required Set<String> target,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (_) {
              _addCustomFood(controller: controller, target: target);
            },
          ),
        ),
        const SizedBox(width: 8),
        IconButton.filled(
          onPressed: () {
            _addCustomFood(controller: controller, target: target);
          },
          icon: const Icon(Icons.add),
          tooltip: 'Добавить',
        ),
      ],
    );
  }

  Widget _buildSelectedFoods(Set<String> foods) {
    if (foods.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: foods.map((food) {
          return Chip(
            label: Text(food),
            deleteIcon: const Icon(Icons.close),
            onDeleted: () {
              setState(() {
                foods.remove(food);
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Future<void> _saveAndFinish() async {
    if (_isSaving) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final saved = await _database.updateFamilyMember(
        id: widget.member.id,
        name: widget.member.name,
        goal: widget.goal,
        activity: widget.activity,
        dietType: _dietType,
        allergies: _encodeSet(_allergies),
        intolerances: _encodeSet(_intolerances),
        dislikedFoods: _encodeSet(_dislikedFoods),
        likedFoods: _encodeSet(_likedFoods),
        preferences: _preferencesController.text.trim(),
      );

      if (!saved) {
        if (!mounted) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Не удалось сохранить настройки питания'),
          ),
        );
        return;
      }

      final storedMember = await _database.getFamilyMember(widget.member.id);

      if (storedMember == null) {
        throw Exception('Участник семьи не найден');
      }

      final families = await _database.getAllFamilies();

      db.Family? family;

      for (final item in families) {
        if (item.id == storedMember.familyId) {
          family = item;
          break;
        }
      }

      if (!mounted) {
        return;
      }

      if (family == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Настройки сохранены, но семья не найдена'),
          ),
        );
        return;
      }

      final targetFamily = family;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Настройки питания для ${widget.member.name} сохранены',
          ),
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => FamilyMembersScreen(
            familyId: targetFamily.id,
            familyName: targetFamily.name,
          ),
        ),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Ошибка сохранения: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _customAllergyController.dispose();
    _customIntoleranceController.dispose();
    _customDislikeController.dispose();
    _customLikeController.dispose();
    _preferencesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.member.name)),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🥗 Питание и ограничения',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Настройте питание индивидуально для этого члена семьи.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Тип питания',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    RadioGroup<String>(
                      groupValue: _dietType,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _dietType = value;
                          });
                        }
                      },
                      child: Column(
                        children: _dietTypes.map((diet) {
                          return RadioListTile<String>(
                            value: diet['value']!,
                            title: Text('${diet['icon']}  ${diet['title']}'),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildChoiceSection(
                      title: '⚠️ Аллергии',
                      subtitle: 'Эти продукты нельзя использовать при составлении меню.',
                      options: _allergyOptions,
                      selected: _allergies,
                    ),
                    const Text(
                      'Добавить свой аллерген',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    _buildCustomFoodInput(
                      hint: 'Например: клубника',
                      controller: _customAllergyController,
                      target: _allergies,
                    ),
                    _buildSelectedFoods(_allergies),
                    const SizedBox(height: 28),
                    _buildChoiceSection(
                      title: 'Непереносимости',
                      subtitle: 'Эти продукты нужно ограничить или исключить.',
                      options: _intoleranceOptions,
                      selected: _intolerances,
                    ),
                    const Text(
                      'Добавить свою непереносимость',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    _buildCustomFoodInput(
                      hint: 'Например: сорбит',
                      controller: _customIntoleranceController,
                      target: _intolerances,
                    ),
                    _buildSelectedFoods(_intolerances),
                    const SizedBox(height: 28),
                    _buildChoiceSection(
                      title: '👎 Не люблю',
                      subtitle: 'Приложение постарается не использовать эти продукты.',
                      options: _foodOptions,
                      selected: _dislikedFoods,
                    ),
                    const Text(
                      'Добавить свой нелюбимый продукт',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    _buildCustomFoodInput(
                      hint: 'Например: печень',
                      controller: _customDislikeController,
                      target: _dislikedFoods,
                    ),
                    _buildSelectedFoods(_dislikedFoods),
                    const SizedBox(height: 28),
                    _buildChoiceSection(
                      title: '❤️ Люблю',
                      subtitle: 'Приложение будет стараться использовать эти продукты чаще.',
                      options: _foodOptions,
                      selected: _likedFoods,
                    ),
                    const Text(
                      'Добавить свой любимый продукт',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    _buildCustomFoodInput(
                      hint: 'Например: сыр',
                      controller: _customLikeController,
                      target: _likedFoods,
                    ),
                    _buildSelectedFoods(_likedFoods),
                    const SizedBox(height: 28),
                    const Text(
                      '📝 Дополнительные предпочтения',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Напишите своими словами всё, что важно учитывать при составлении меню.',
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _preferencesController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Например: люблю рыбу, кроме лосося. Люблю сыр, курицу и авокадо. Овощи предпочитаю приготовленные.',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 36),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isSaving ? null : _saveAndFinish,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: _isSaving
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Сохранить профиль',
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

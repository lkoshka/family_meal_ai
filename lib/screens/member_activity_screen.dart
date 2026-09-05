import 'package:flutter/material.dart';

import '../database/app_database.dart' as db;
import '../models/family_member.dart';
import 'member_food_preferences_screen.dart';

class MemberActivityScreen extends StatefulWidget {
  final FamilyMember member;
  final String goal;

  const MemberActivityScreen({
    super.key,
    required this.member,
    required this.goal,
  });

  @override
  State<MemberActivityScreen> createState() => _MemberActivityScreenState();
}

class _MemberActivityScreenState extends State<MemberActivityScreen> {
  final db.AppDatabase _database = db.AppDatabase();

  String? _selectedActivity;

  bool _isLoading = true;
  bool _isSaving = false;

  final List<Map<String, String>> _activities = [
    {
      'value': 'sedentary',
      'title': 'Минимальная',
      'subtitle': 'В основном сидячий образ жизни, мало движения',
      'icon': '🪑',
    },
    {
      'value': 'light',
      'title': 'Лёгкая',
      'subtitle': 'Лёгкая активность или тренировки 1–3 раза в неделю',
      'icon': '🚶',
    },
    {
      'value': 'moderate',
      'title': 'Средняя',
      'subtitle':
          'Регулярные тренировки или активный образ жизни 3–5 раз в неделю',
      'icon': '🏃',
    },
    {
      'value': 'high',
      'title': 'Высокая',
      'subtitle': 'Интенсивные тренировки 6–7 раз в неделю',
      'icon': '🏋️',
    },
    {
      'value': 'very_high',
      'title': 'Очень высокая',
      'subtitle': 'Тяжёлые тренировки и/или физически активная работа',
      'icon': '🔥',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadActivity();
  }

  Future<void> _loadActivity() async {
    try {
      final member = await _database.getFamilyMember(widget.member.id);

      if (!mounted) {
        return;
      }

      setState(() {
        _selectedActivity = member?.activity;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось загрузить уровень активности: $e')),
      );
    }
  }

  Future<void> _continue() async {
    if (_selectedActivity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите уровень активности')),
      );
      return;
    }

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
        activity: _selectedActivity,
      );

      if (!mounted) {
        return;
      }

      if (!saved) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Не удалось сохранить уровень активности'),
          ),
        );
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MemberFoodPreferencesScreen(
            member: widget.member,
            goal: widget.goal,
            activity: _selectedActivity!,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка сохранения активности: $e')),
      );
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.member.name)),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🏃 Активность',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Как обычно проходит физическая активность?',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: RadioGroup<String>(
                        groupValue: _selectedActivity,
                        onChanged: (value) {
                          setState(() {
                            _selectedActivity = value;
                          });
                        },
                        child: ListView.builder(
                          itemCount: _activities.length,
                          itemBuilder: (context, index) {
                            final activity = _activities[index];

                            final selected =
                                _selectedActivity == activity['value'];

                            return Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                leading: Text(
                                  activity['icon']!,
                                  style: const TextStyle(fontSize: 28),
                                ),
                                title: Text(
                                  activity['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(activity['subtitle']!),
                                trailing: Radio<String>(
                                  value: activity['value']!,
                                ),
                                selected: selected,
                                onTap: () {
                                  setState(() {
                                    _selectedActivity = activity['value'];
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isSaving ? null : _continue,
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
                                  'Сохранить и продолжить',
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

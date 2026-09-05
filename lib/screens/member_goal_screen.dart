import 'package:flutter/material.dart';

import '../database/app_database.dart' as db;
import '../models/family_member.dart';
import 'member_activity_screen.dart';

class MemberGoalScreen extends StatefulWidget {
  final FamilyMember member;

  const MemberGoalScreen({super.key, required this.member});

  @override
  State<MemberGoalScreen> createState() => _MemberGoalScreenState();
}

class _MemberGoalScreenState extends State<MemberGoalScreen> {
  final db.AppDatabase _database = db.AppDatabase();

  String? _selectedGoal;

  bool _isLoading = true;
  bool _isSaving = false;

  final List<Map<String, String>> _goals = [
    {
      'value': 'weight_loss',
      'title': 'Снижение веса',
      'subtitle': 'Постепенное и безопасное снижение веса',
      'icon': '📉',
    },
    {
      'value': 'maintenance',
      'title': 'Поддержание веса',
      'subtitle': 'Сохранить текущий вес',
      'icon': '⚖️',
    },
    {
      'value': 'weight_gain',
      'title': 'Набор веса',
      'subtitle': 'Постепенно увеличить вес',
      'icon': '📈',
    },
    {
      'value': 'muscle',
      'title': 'Мышцы и физическая форма',
      'subtitle': 'Поддержка тренировок и мышечной массы',
      'icon': '💪',
    },
    {
      'value': 'healthy',
      'title': 'Здоровое питание',
      'subtitle': 'Сбалансированный рацион без конкретной цели по весу',
      'icon': '🥗',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadGoal();
  }

  Future<void> _loadGoal() async {
    try {
      final member = await _database.getFamilyMember(widget.member.id);

      if (!mounted) {
        return;
      }

      setState(() {
        _selectedGoal = member?.goal;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Не удалось загрузить цель: $e')));
    }
  }

  Future<void> _continue() async {
    if (_selectedGoal == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Выберите цель')));
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
        goal: _selectedGoal,
      );

      if (!mounted) {
        return;
      }

      if (!saved) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Не удалось сохранить цель')),
        );
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MemberActivityScreen(member: widget.member, goal: _selectedGoal!),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Ошибка сохранения цели: $e')));
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
                      '🎯 Цель питания',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Выберите цель для ${widget.member.name}.',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: RadioGroup<String>(
                        groupValue: _selectedGoal,
                        onChanged: (value) {
                          setState(() {
                            _selectedGoal = value;
                          });
                        },
                        child: ListView.builder(
                          itemCount: _goals.length,
                          itemBuilder: (context, index) {
                            final goal = _goals[index];
                            final selected = _selectedGoal == goal['value'];

                            return Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                leading: Text(
                                  goal['icon']!,
                                  style: const TextStyle(fontSize: 28),
                                ),
                                title: Text(
                                  goal['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(goal['subtitle']!),
                                trailing: Radio<String>(value: goal['value']!),
                                selected: selected,
                                onTap: () {
                                  setState(() {
                                    _selectedGoal = goal['value'];
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

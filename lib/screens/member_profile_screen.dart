import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../models/family_member.dart' as model;
import 'member_goal_screen.dart';

class MemberProfileScreen extends StatefulWidget {
  final int memberId;
  final String memberName;

  const MemberProfileScreen({
    super.key,
    required this.memberId,
    required this.memberName,
  });

  @override
  State<MemberProfileScreen> createState() => _MemberProfileScreenState();
}

class _MemberProfileScreenState extends State<MemberProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final AppDatabase _database = AppDatabase();

  DateTime? _birthDate;
  String? _gender;

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadMember();
  }

  Future<void> _loadMember() async {
    final member = await _database.getFamilyMember(widget.memberId);

    if (!mounted) {
      return;
    }

    if (member != null) {
      setState(() {
        _birthDate = member.birthDate;
        _gender = member.gender;
        _heightController.text = member.heightCm?.toString() ?? '';
        _weightController.text = member.weightKg?.toString() ?? '';
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _selectBirthDate() async {
    final now = DateTime.now();

    final initialDate =
        _birthDate ?? DateTime(now.year - 30, now.month, now.day);

    final result = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: 'Выберите дату рождения',
      cancelText: 'Отмена',
      confirmText: 'Готово',
    );

    if (!mounted) {
      return;
    }

    if (result != null) {
      setState(() {
        _birthDate = result;
      });
    }
  }

  Future<void> _continue() async {
    if (_isSaving) {
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_birthDate == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Укажите дату рождения')));
      return;
    }

    if (_gender == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Выберите пол')));
      return;
    }

    final height = double.tryParse(
      _heightController.text.trim().replaceAll(',', '.'),
    );

    final weight = double.tryParse(
      _weightController.text.trim().replaceAll(',', '.'),
    );

    if (height == null || weight == null) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await _database.updateFamilyMember(
        id: widget.memberId,
        name: widget.memberName,
        birthDate: _birthDate,
        gender: _gender,
        heightCm: height,
        weightKg: weight,
      );

      final member = model.FamilyMember(
        id: widget.memberId,
        name: widget.memberName,
        birthDate: _birthDate!,
        gender: _gender == 'female' ? model.Gender.female : model.Gender.male,
        heightCm: height,
        weightKg: weight,
      );

      if (!mounted) {
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MemberGoalScreen(member: member),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day.$month.${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.memberName)),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Профиль ${widget.memberName}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Введите данные участника семьи.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 32),

                      const Text(
                        'Дата рождения',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _selectBirthDate,
                          icon: const Icon(Icons.calendar_today),
                          label: Text(
                            _birthDate == null
                                ? 'Выбрать дату'
                                : _formatDate(_birthDate!),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Пол',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      RadioGroup<String>(
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                        child: const Column(
                          children: [
                            RadioListTile<String>(
                              title: Text('Женский'),
                              value: 'female',
                            ),
                            RadioListTile<String>(
                              title: Text('Мужской'),
                              value: 'male',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _heightController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Рост',
                          suffixText: 'см',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Введите рост';
                          }

                          final height = double.tryParse(
                            value.trim().replaceAll(',', '.'),
                          );

                          if (height == null || height < 40 || height > 250) {
                            return 'Введите корректный рост';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _weightController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Вес',
                          suffixText: 'кг',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Введите вес';
                          }

                          final weight = double.tryParse(
                            value.trim().replaceAll(',', '.'),
                          );

                          if (weight == null || weight < 2 || weight > 300) {
                            return 'Введите корректный вес';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _isSaving ? null : _continue,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: _isSaving
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Продолжить',
                                    style: TextStyle(fontSize: 18),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

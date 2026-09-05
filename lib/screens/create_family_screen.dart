import 'package:flutter/material.dart';

import '../database/app_database.dart';
import 'family_members_screen.dart';

class CreateFamilyScreen extends StatefulWidget {
  const CreateFamilyScreen({super.key});

  @override
  State<CreateFamilyScreen> createState() => _CreateFamilyScreenState();
}

class _CreateFamilyScreenState extends State<CreateFamilyScreen> {
  final TextEditingController _familyNameController = TextEditingController();

  final AppDatabase _database = AppDatabase();

  bool _saving = false;

  @override
  void dispose() {
    _familyNameController.dispose();
    super.dispose();
  }

  Future<void> _createFamily() async {
    final familyName = _familyNameController.text.trim();

    if (familyName.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Введите название семьи')));
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      final familyId = await _database.createFamily(familyName);

      if (!mounted) {
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              FamilyMembersScreen(familyId: familyId, familyName: familyName),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _saving = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Не удалось сохранить семью: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Создание семьи')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('👨‍👩‍👧‍👦', style: TextStyle(fontSize: 48)),

              const SizedBox(height: 20),

              const Text(
                'Создадим вашу семью',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              const Text(
                'Введите название семьи. Его можно будет изменить позже.',
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 32),

              TextField(
                controller: _familyNameController,
                decoration: const InputDecoration(
                  labelText: 'Название семьи',
                  hintText: 'Например: Наша семья',
                  border: OutlineInputBorder(),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _saving ? null : _createFamily,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: _saving
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
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

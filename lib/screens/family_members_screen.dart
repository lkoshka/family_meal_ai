import 'package:flutter/material.dart';

import '../database/app_database.dart';
import 'family_summary_screen.dart';
import 'member_profile_screen.dart';
import 'pantry_screen.dart';

class FamilyMembersScreen extends StatefulWidget {
  final int familyId;
  final String familyName;

  const FamilyMembersScreen({
    super.key,
    required this.familyId,
    required this.familyName,
  });

  @override
  State<FamilyMembersScreen> createState() => _FamilyMembersScreenState();
}

class _FamilyMembersScreenState extends State<FamilyMembersScreen> {
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

  bool _isProfileComplete(FamilyMember member) {
    return member.birthDate != null &&
        member.gender != null &&
        member.heightCm != null &&
        member.weightKg != null &&
        member.goal != null &&
        member.activity != null &&
        member.dietType != null;
  }

  int get _completedProfilesCount {
    return _members.where(_isProfileComplete).length;
  }

  List<FamilyMember> get _incompleteMembers {
    return _members.where((member) => !_isProfileComplete(member)).toList();
  }

  Future<void> _addMember() async {
    if (_members.length >= 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Можно добавить максимум 8 членов семьи.'),
        ),
      );
      return;
    }

    final controller = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Добавить члена семьи'),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Имя',
              hintText: 'Например, Анна',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Отмена'),
            ),
            FilledButton(
              onPressed: () async {
                final name = controller.text.trim();

                if (name.isEmpty) {
                  return;
                }

                await _database.addFamilyMember(
                  familyId: widget.familyId,
                  name: name,
                );

                if (!dialogContext.mounted) {
                  return;
                }

                Navigator.pop(dialogContext);
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (!mounted) {
      return;
    }

    await _loadMembers();
  }

  Future<void> _confirmRemoveMember(FamilyMember member) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Удалить члена семьи?'),
          content: Text(
            'Удалить ${member.name} и все сохранённые данные анкеты?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Отмена'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    await _database.deleteFamilyMember(member.id);

    if (!mounted) {
      return;
    }

    await _loadMembers();
  }

  Future<void> _openMember(FamilyMember member) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MemberProfileScreen(memberId: member.id, memberName: member.name),
      ),
    );

    if (!mounted) {
      return;
    }

    await _loadMembers();
  }

  void _continue() {
    if (_members.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Добавьте минимум двух членов семьи.')),
      );
      return;
    }

    final incomplete = _incompleteMembers;

    if (incomplete.isNotEmpty) {
      final names = incomplete.map((member) => member.name).join(', ');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Сначала заполните анкеты: $names')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FamilySummaryScreen(
          familyId: widget.familyId,
          familyName: widget.familyName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.familyName)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('👨‍👩‍👧‍👦', style: TextStyle(fontSize: 48)),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PantryScreen(familyId: widget.familyId),
                      ),
                    );
                  },
                  icon: const Icon(Icons.home_outlined),
                  label: const Text('Продукты дома'),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Кто входит в семью?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Добавьте от 2 до 8 членов семьи и заполните анкету каждого.',
                style: TextStyle(fontSize: 16),
              ),

              if (_members.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Заполнено анкет: $_completedProfilesCount из ${_members.length}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _completedProfilesCount == _members.length
                        ? Colors.green
                        : null,
                  ),
                ),
              ],

              const SizedBox(height: 20),

              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _members.isEmpty
                  ? const Center(
                      child: Text(
                        'Пока никого нет.\n'
                        'Добавьте первого члена семьи.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _members.length,
                      itemBuilder: (context, index) {
                        final member = _members[index];
                        final complete = _isProfileComplete(member);

                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                member.name.isEmpty
                                    ? '?'
                                    : member.name[0].toUpperCase(),
                              ),
                            ),
                            title: Text(
                              member.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              complete
                                  ? 'Анкета заполнена'
                                  : 'Нужно заполнить анкету',
                            ),
                            onTap: () => _openMember(member),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  complete
                                      ? Icons.check_circle
                                      : Icons.pending_outlined,
                                  color: complete ? Colors.green : null,
                                ),
                                const SizedBox(width: 4),
                                IconButton(
                                  tooltip: 'Удалить',
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () => _confirmRemoveMember(member),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _members.length >= 8 ? null : _addMember,
                  icon: const Icon(Icons.person_add),
                  label: Text(
                    _members.length >= 8
                        ? 'Достигнут максимум — 8 человек'
                        : 'Добавить члена семьи',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _members.length >= 2 ? _continue : null,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Продолжить', style: TextStyle(fontSize: 18)),
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

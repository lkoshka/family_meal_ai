import 'package:flutter/material.dart';

import 'database/app_database.dart';
import 'screens/create_family_screen.dart';
import 'screens/family_members_screen.dart';
import 'services/food_product_seeder.dart';
import 'services/recipe_seeder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  await FoodProductSeeder.seedIfNeeded(database);
  await RecipeSeeder.seedIfNeeded(database);
  runApp(const FamilyMealAI());
}

class FamilyMealAI extends StatelessWidget {
  const FamilyMealAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Family Meal AI',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final AppDatabase _database = AppDatabase();

  Family? _existingFamily;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExistingFamily();
  }

  Future<void> _loadExistingFamily() async {
    try {
      final family = await _database.getFirstFamily();

      if (!mounted) {
        return;
      }

      setState(() {
        _existingFamily = family;
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
        SnackBar(content: Text('Не удалось загрузить сохранённую семью: $e')),
      );
    }
  }

  void _createFamily() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateFamilyScreen()),
    );
  }

  void _openExistingFamily() {
    final family = _existingFamily;

    if (family == null) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FamilyMembersScreen(familyId: family.id, familyName: family.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.restaurant_menu, size: 80),
                const SizedBox(height: 24),
                const Text(
                  'Family Meal AI',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Персональное питание\nдля всей семьи',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _createFamily,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Создать семью',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _existingFamily == null
                          ? null
                          : _openExistingFamily,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          _existingFamily == null
                              ? 'Сохранённой семьи пока нет'
                              : 'Открыть семью: ${_existingFamily!.name}',
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
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

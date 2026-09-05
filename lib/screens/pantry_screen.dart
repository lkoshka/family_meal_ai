import 'package:flutter/material.dart';

import '../database/app_database.dart';

class PantryScreen extends StatefulWidget {
  final int familyId;

  const PantryScreen({super.key, required this.familyId});

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  final AppDatabase _database = AppDatabase();

  List<PantryProduct> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _database.getAllProducts(widget.familyId);

      if (!mounted) {
        return;
      }

      setState(() {
        _products = products;
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
      ).showSnackBar(SnackBar(content: Text('Ошибка загрузки продуктов: $e')));
    }
  }

  Future<void> _addProduct() async {
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    String unit = 'шт.';

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: const Text('Добавить продукт'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Продукт',
                        hintText: 'Например: яйца',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Количество',
                              hintText: '10',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: unit,
                            decoration: const InputDecoration(
                              labelText: 'Единица',
                              border: OutlineInputBorder(),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'шт.',
                                child: Text('шт.'),
                              ),
                              DropdownMenuItem(value: 'г', child: Text('г')),
                              DropdownMenuItem(value: 'кг', child: Text('кг')),
                              DropdownMenuItem(value: 'мл', child: Text('мл')),
                              DropdownMenuItem(value: 'л', child: Text('л')),
                              DropdownMenuItem(
                                value: 'уп.',
                                child: Text('уп.'),
                              ),
                              DropdownMenuItem(
                                value: 'банка',
                                child: Text('банка'),
                              ),
                              DropdownMenuItem(
                                value: 'пачка',
                                child: Text('пачка'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setDialogState(() {
                                  unit = value;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
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
                    final name = nameController.text.trim();
                    final amount = amountController.text.trim();

                    if (name.isEmpty || amount.isEmpty) {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        const SnackBar(
                          content: Text('Введите продукт и количество'),
                        ),
                      );
                      return;
                    }

                    try {
                      await _database.addProduct(
                        familyId: widget.familyId,
                        name: name,
                        amount: amount,
                        unit: unit,
                      );

                      if (!dialogContext.mounted) {
                        return;
                      }

                      Navigator.pop(dialogContext);
                    } catch (e) {
                      if (!dialogContext.mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        SnackBar(
                          content: Text('Ошибка сохранения продукта: $e'),
                        ),
                      );
                    }
                  },
                  child: const Text('Сохранить'),
                ),
              ],
            );
          },
        );
      },
    );

    nameController.dispose();
    amountController.dispose();

    if (!mounted) {
      return;
    }

    await _loadProducts();
  }

  Future<void> _removeProduct(int id) async {
    try {
      await _database.deleteProduct(id);

      if (!mounted) {
        return;
      }

      await _loadProducts();
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка удаления продукта: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Продукты дома')),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _products.isEmpty
            ? _buildEmptyState()
            : _buildProductList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🛒', style: TextStyle(fontSize: 60)),
            const SizedBox(height: 16),
            const Text(
              'Продуктов пока нет',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Добавьте продукты, которые сейчас есть дома. '
              'Они будут учитываться при планировании меню.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _addProduct,
              icon: const Icon(Icons.add),
              label: const Text('Добавить продукт'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              final product = _products[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.shopping_basket),
                  ),
                  title: Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text('${product.amount} ${product.unit}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      _removeProduct(product.id);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _addProduct,
              icon: const Icon(Icons.add),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Добавить продукт', style: TextStyle(fontSize: 17)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

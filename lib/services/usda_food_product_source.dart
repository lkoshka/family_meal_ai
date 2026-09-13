import 'dart:convert';

import 'package:http/http.dart' as http;

import 'food_product_source.dart';

class UsdaFoodProductSource implements FoodProductSource {
  const UsdaFoodProductSource({required this.apiKey});

  final String apiKey;

  @override
  Future<FoodProductSourceResult?> findProduct(String name) async {
    final uri = Uri.https('api.nal.usda.gov', '/fdc/v1/foods/search', {
      'api_key': apiKey,
      'query': name,
      'pageSize': '5',
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return null;
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final foods = json['foods'] as List<dynamic>?;

    if (foods == null || foods.isEmpty) {
      return null;
    }

    return null;
  }
}

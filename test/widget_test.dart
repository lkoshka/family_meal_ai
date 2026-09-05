import 'package:flutter_test/flutter_test.dart';

import 'package:family_meal_ai/main.dart';

void main() {
  testWidgets('Family Meal AI запускается', (WidgetTester tester) async {
    await tester.pumpWidget(const FamilyMealAI());

    expect(find.text('Family Meal AI'), findsOneWidget);
  });
}

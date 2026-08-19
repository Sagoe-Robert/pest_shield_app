import 'package:flutter_test/flutter_test.dart';

import 'package:pest_shield_app/main.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {
    await tester.pumpWidget(const PestShieldApp());
    expect(find.text('Pest Shield'), findsOneWidget);
  });
}

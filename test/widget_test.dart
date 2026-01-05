import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tutorial/init_setup/firstpage.dart';

void main() {
  testWidgets('App starts', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: FirstPage(),
      ),
    );

    expect(find.byType(Scaffold), findsOneWidget);
  });
}

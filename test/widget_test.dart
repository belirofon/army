import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:army/features/quest/presentation/screens/home_screen.dart';

void main() {
  testWidgets('Home screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    // Verify that the app title is displayed
    expect(find.text('АРМЕЙСКИЕ'), findsOneWidget);
    expect(find.text('БУДНИ'), findsOneWidget);
    
    // Verify that the main menu buttons are displayed
    expect(find.text('НАЧАТЬ ИГРУ'), findsOneWidget);
    expect(find.text('АРМЕЙСКИЙ СОСТАВ'), findsOneWidget);
    expect(find.text('ДОСТИЖЕНИЯ'), findsOneWidget);
  });
}

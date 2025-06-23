// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:football_api_test/main.dart';

void main() {
  setUpAll(() {
    // Initialize FFI for testing
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('Football app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FootballApp());

    // Verify that our app starts with the teams list screen.
    expect(find.text('Premier League Teams'), findsOneWidget);
    
    // Wait for the initial state to settle
    await tester.pump();
    
    // Verify the favorites button is present.
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // Verify search bar is present.
    expect(find.text('Search teams...'), findsOneWidget);

    // Verify view mode toggle and sort buttons are present.
    expect(find.byIcon(Icons.sort), findsOneWidget);
    expect(find.byIcon(Icons.grid_view), findsOneWidget);

    // Verify footer attribution is present.
    expect(
      find.text('Football data provided by the Football-Data.org API'),
      findsOneWidget,
    );
  });
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clone_messagers/services/services.dart';
import 'package:clone_messagers/screens/screens.dart';

void main() {
  testWidgets('Messenger app loads correctly', (WidgetTester tester) async {
    // Build our app with a simplified version that doesn't need async initialization
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          home: const ConversationListScreen(),
        ),
      ),
    );

    // Wait for the conversation provider to load data
    await tester.pumpAndSettle();

    // Verify that the conversation list screen loads
    expect(find.text('Messenger'), findsOneWidget);

    // Verify that conversations are displayed (should have sample data)
    expect(find.byType(ListView), findsOneWidget);

    // Verify that at least one conversation tile is present
    // (We know from sample data that there should be conversations)
    expect(find.text('John Doe'), findsOneWidget);
  });
}

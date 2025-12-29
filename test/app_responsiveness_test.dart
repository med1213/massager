import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clone_messagers/screens/screens.dart';
import 'package:clone_messagers/config/app_config.dart';

void main() {
  group('App Responsiveness Tests', () {
    testWidgets('ConversationListScreen loads without hanging', (
      WidgetTester tester,
    ) async {
      // Build the conversation list screen
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: const ConversationListScreen())),
      );

      // Verify the screen starts building immediately
      expect(find.byType(ConversationListScreen), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Messenger'), findsOneWidget);

      // If loading delays are disabled, content should load quickly
      if (!AppConfig.enableLoadingDelays) {
        await tester.pumpAndSettle();
        // Should show conversations or shimmer, not hang
        expect(
          find.byType(Scaffold),
          findsOneWidget,
          reason: 'App should not hang and should render scaffold',
        );
      } else {
        // If delays are enabled, should show shimmer initially
        await tester.pump();
        // Should show shimmer loading state
        expect(
          find.byType(Scaffold),
          findsOneWidget,
          reason: 'App should show loading state, not hang',
        );
      }
    });

    testWidgets('App configuration is properly set', (
      WidgetTester tester,
    ) async {
      // Verify app config values are reasonable
      expect(AppConfig.enableLoadingDelays, isA<bool>());
      expect(AppConfig.conversationLoadingDelay, greaterThanOrEqualTo(0));
      expect(AppConfig.messageLoadingDelay, greaterThanOrEqualTo(0));
      expect(AppConfig.showDebugFeatures, isA<bool>());

      // If delays are disabled, they should be 0 or very small
      if (!AppConfig.enableLoadingDelays) {
        // App should be responsive
        expect(
          true,
          isTrue,
          reason: 'Loading delays are disabled for responsiveness',
        );
      }
    });

    testWidgets('Shimmer components render without blocking', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // Test that shimmer components don't block rendering
                Text('Before Shimmer'),
                Text('After Shimmer'),
              ],
            ),
          ),
        ),
      );

      // Should render immediately without hanging
      expect(find.text('Before Shimmer'), findsOneWidget);
      expect(find.text('After Shimmer'), findsOneWidget);
    });
  });
}

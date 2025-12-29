import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clone_messagers/screens/screens.dart';
import 'package:clone_messagers/widgets/widgets.dart';
import 'package:clone_messagers/services/services.dart';
import 'package:clone_messagers/routes/app_routes.dart';

void main() {
  group('Integration Tests - Complete User Workflows', () {
    testWidgets('Complete conversation viewing and messaging workflow', (
      WidgetTester tester,
    ) async {
      // Build the complete app
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            initialRoute: AppRoutes.conversationList,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        ),
      );

      // Wait for app to load
      await tester.pumpAndSettle();

      // Verify conversation list screen loads
      expect(find.text('Messenger'), findsOneWidget);
      expect(find.byType(ConversationListScreen), findsOneWidget);

      // Verify conversations are displayed
      expect(find.byType(ConversationTile), findsAtLeastNWidgets(1));
      expect(find.text('John Doe'), findsOneWidget);

      // Tap on first conversation to navigate to chat
      await tester.tap(find.byType(ConversationTile).first);
      await tester.pumpAndSettle();

      // Verify navigation to chat screen
      expect(find.byType(ChatScreen), findsOneWidget);
      expect(find.byType(MessageBubble), findsAtLeastNWidgets(1));

      // Verify message composer is present
      expect(find.byType(MessageComposer), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      // Test sending a message
      final textField = find.byType(TextField);
      await tester.enterText(textField, 'Hello, this is a test message!');
      await tester.pumpAndSettle();

      // Verify send button is enabled and tap it
      final sendButton = find.byIcon(Icons.send);
      expect(sendButton, findsOneWidget);
      await tester.tap(sendButton);
      await tester.pumpAndSettle();

      // Verify message was sent and appears in chat
      expect(find.text('Hello, this is a test message!'), findsOneWidget);

      // Verify text field is cleared after sending
      final textFieldWidget = tester.widget<TextField>(textField);
      expect(textFieldWidget.controller?.text, isEmpty);

      // Test navigation back to conversation list
      final backButton = find.byIcon(Icons.arrow_back);
      expect(backButton, findsOneWidget);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Verify we're back on conversation list
      expect(find.byType(ConversationListScreen), findsOneWidget);
      expect(find.text('Messenger'), findsOneWidget);
    });

    testWidgets('Navigation flows between screens', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            initialRoute: AppRoutes.conversationList,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Start on conversation list
      expect(find.byType(ConversationListScreen), findsOneWidget);

      // Navigate to different conversations
      final conversationTiles = find.byType(ConversationTile);
      final tileCount = tester.widgetList(conversationTiles).length;
      expect(tileCount, greaterThan(1));

      // Test navigation to first conversation
      await tester.tap(conversationTiles.first);
      await tester.pumpAndSettle();
      expect(find.byType(ChatScreen), findsOneWidget);

      // Navigate back
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byType(ConversationListScreen), findsOneWidget);

      // Test navigation to second conversation if available
      if (tileCount > 1) {
        await tester.tap(conversationTiles.at(1));
        await tester.pumpAndSettle();
        expect(find.byType(ChatScreen), findsOneWidget);

        // Navigate back again
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        expect(find.byType(ConversationListScreen), findsOneWidget);
      }
    });

    testWidgets('Message composition and UI interactions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            initialRoute: AppRoutes.conversationList,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Navigate to a chat
      await tester.tap(find.byType(ConversationTile).first);
      await tester.pumpAndSettle();

      // Test message composition workflow
      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      // Test typing in composer
      await tester.enterText(textField, 'Test message 1');
      await tester.pumpAndSettle();

      // Verify send button is enabled
      final sendButton = find.byIcon(Icons.send);
      expect(sendButton, findsOneWidget);

      // Send the message
      await tester.tap(sendButton);
      await tester.pumpAndSettle();

      // Verify message appears
      expect(find.text('Test message 1'), findsOneWidget);

      // Test sending another message
      await tester.enterText(textField, 'Test message 2');
      await tester.pumpAndSettle();
      await tester.tap(sendButton);
      await tester.pumpAndSettle();

      // Verify both messages appear
      expect(find.text('Test message 1'), findsOneWidget);
      expect(find.text('Test message 2'), findsOneWidget);

      // Test empty message handling
      await tester.enterText(textField, '');
      await tester.pumpAndSettle();
      await tester.tap(sendButton);
      await tester.pumpAndSettle();

      // Verify empty message wasn't sent (still only 2 test messages)
      expect(find.text('Test message 1'), findsOneWidget);
      expect(find.text('Test message 2'), findsOneWidget);
    });

    testWidgets('UI responsiveness and layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            initialRoute: AppRoutes.conversationList,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Test conversation list layout
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ConversationTile), findsAtLeastNWidgets(1));

      // Navigate to chat
      await tester.tap(find.byType(ConversationTile).first);
      await tester.pumpAndSettle();

      // Test chat screen layout
      expect(find.byType(MessageBubble), findsAtLeastNWidgets(1));
      expect(find.byType(MessageComposer), findsOneWidget);

      // Test that message bubbles have proper styling
      final messageBubbles = find.byType(MessageBubble);
      expect(messageBubbles, findsAtLeastNWidgets(1));

      // Verify message composer is at bottom
      final composer = find.byType(MessageComposer);
      expect(composer, findsOneWidget);

      // Test scrolling behavior
      final listView = find.byType(ListView);
      if (listView.evaluate().isNotEmpty) {
        await tester.drag(listView, const Offset(0, -100));
        await tester.pumpAndSettle();
        // Should still be able to scroll back
        await tester.drag(listView, const Offset(0, 100));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Data consistency across navigation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            initialRoute: AppRoutes.conversationList,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Get initial conversation count
      final initialConversations = find.byType(ConversationTile);
      final initialCount = tester.widgetList(initialConversations).length;

      // Navigate to first conversation
      await tester.tap(initialConversations.first);
      await tester.pumpAndSettle();

      // Send a message
      final textField = find.byType(TextField);
      await tester.enterText(textField, 'Data consistency test message');
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      // Navigate back
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Verify conversation list still has same number of conversations
      final finalConversations = find.byType(ConversationTile);
      final finalCount = tester.widgetList(finalConversations).length;
      expect(finalCount, equals(initialCount));

      // Navigate back to same conversation
      await tester.tap(finalConversations.first);
      await tester.pumpAndSettle();

      // Verify our sent message is still there
      expect(find.text('Data consistency test message'), findsOneWidget);
    });

    testWidgets('Error handling and edge cases', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            initialRoute: AppRoutes.conversationList,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Test navigation to chat
      await tester.tap(find.byType(ConversationTile).first);
      await tester.pumpAndSettle();

      // Test sending whitespace-only message
      final textField = find.byType(TextField);
      await tester.enterText(textField, '   ');
      await tester.pumpAndSettle();

      // Get initial message count
      final initialMessageBubbles = find.byType(MessageBubble);
      final initialCount = tester.widgetList(initialMessageBubbles).length;

      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      // Verify whitespace message wasn't sent (message count unchanged)
      final finalMessageBubbles = find.byType(MessageBubble);
      final finalCount = tester.widgetList(finalMessageBubbles).length;
      expect(finalCount, equals(initialCount));

      // Test sending very long message
      final longMessage =
          'This is a very long message that should wrap properly and not break the UI layout. ' *
          5;
      await tester.enterText(textField, longMessage);
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      // Verify long message appears (should be wrapped)
      expect(
        find.textContaining('This is a very long message'),
        findsOneWidget,
      );

      // Test rapid message sending
      for (int i = 0; i < 3; i++) {
        await tester.enterText(textField, 'Rapid message $i');
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.send));
        await tester.pumpAndSettle();
      }

      // Verify all rapid messages appear
      expect(find.text('Rapid message 0'), findsOneWidget);
      expect(find.text('Rapid message 1'), findsOneWidget);
      expect(find.text('Rapid message 2'), findsOneWidget);
    });
  });
}

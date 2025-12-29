import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clone_messagers/screens/screens.dart';
import 'package:clone_messagers/widgets/widgets.dart';
import 'package:clone_messagers/services/services.dart';

void main() {
  group('ConversationListScreen', () {
    testWidgets('displays conversation list with sample data', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: const ConversationListScreen())),
      );

      // Wait for data to load
      await tester.pumpAndSettle();

      // Verify app bar is present
      expect(find.text('Messenger'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);

      // Verify ListView is present
      expect(find.byType(ListView), findsOneWidget);

      // Verify at least one conversation tile is present
      expect(find.byType(ConversationTile), findsAtLeastNWidgets(1));

      // Verify sample conversations are displayed
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Emma Davis'), findsOneWidget);
    });

    testWidgets('conversation tiles display correct information', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: const ConversationListScreen())),
      );

      await tester.pumpAndSettle();

      // Verify conversation tiles have avatars
      expect(find.byType(CircleAvatar), findsAtLeastNWidgets(1));

      // Verify unread message indicators are shown for conversations with unread messages
      // John Doe should have unread messages based on sample data
      final johnTile = find.ancestor(
        of: find.text('John Doe'),
        matching: find.byType(ConversationTile),
      );
      expect(johnTile, findsOneWidget);
    });

    testWidgets('tapping conversation tile triggers navigation callback', (
      WidgetTester tester,
    ) async {
      bool navigationCalled = false;
      String? navigatedConversationId;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            home: const ConversationListScreen(),
            onGenerateRoute: (settings) {
              if (settings.name?.startsWith('/chat/') == true) {
                navigationCalled = true;
                navigatedConversationId = settings.name!.split('/chat/')[1];
                return MaterialPageRoute(
                  builder: (context) =>
                      Scaffold(body: Text('Chat: $navigatedConversationId')),
                );
              }
              return null;
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap on the first conversation tile
      await tester.tap(find.byType(ConversationTile).first);
      await tester.pumpAndSettle();

      // Verify navigation was triggered
      expect(navigationCalled, isTrue);
      expect(navigatedConversationId, isNotNull);
    });
  });
}

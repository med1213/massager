import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clone_messagers/models/message.dart';
import 'package:clone_messagers/widgets/message_bubble.dart';
import 'package:clone_messagers/theme/messenger_theme.dart';

void main() {
  group('MessageBubble Widget Tests', () {
    late Message testMessage;

    setUp(() {
      testMessage = Message(
        id: 'test-1',
        content: 'Hello, this is a test message!',
        senderId: 'user1',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: true,
      );
    });

    testWidgets('renders sent message with correct styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MessengerTheme.lightTheme,
          home: Scaffold(
            body: MessageBubble(
              message: testMessage,
              isSentByCurrentUser: true,
            ),
          ),
        ),
      );

      // Verify message content is displayed
      expect(find.text('Hello, this is a test message!'), findsOneWidget);

      // Verify timestamp is displayed
      expect(find.textContaining('ago'), findsOneWidget);

      // Verify the container has the correct styling for sent messages
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(MessageBubble),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, MessengerTheme.primaryBlue); // Primary Blue
      expect(decoration.borderRadius, BorderRadius.circular(18.0));
    });

    testWidgets('renders received message with correct styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MessengerTheme.lightTheme,
          home: Scaffold(
            body: MessageBubble(
              message: testMessage,
              isSentByCurrentUser: false,
            ),
          ),
        ),
      );

      // Verify message content is displayed
      expect(find.text('Hello, this is a test message!'), findsOneWidget);

      // Verify the container has the correct styling for received messages
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(MessageBubble),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(
        decoration.color,
        MessengerTheme.messageBubbleReceived,
      ); // Light Gray
      expect(decoration.borderRadius, BorderRadius.circular(18.0));
    });

    testWidgets('applies correct text colors for sent and received messages', (
      WidgetTester tester,
    ) async {
      // Test sent message text color
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageBubble(
              message: testMessage,
              isSentByCurrentUser: true,
            ),
          ),
        ),
      );

      final sentMessageText = tester.widget<Text>(
        find.text('Hello, this is a test message!'),
      );
      expect(sentMessageText.style?.color, Colors.white);

      // Test received message text color
      await tester.pumpWidget(
        MaterialApp(
          theme: MessengerTheme.lightTheme,
          home: Scaffold(
            body: MessageBubble(
              message: testMessage,
              isSentByCurrentUser: false,
            ),
          ),
        ),
      );

      await tester.pump();

      final receivedMessageText = tester.widget<Text>(
        find.text('Hello, this is a test message!'),
      );

      // Get the theme to compare with the actual color used
      final BuildContext context = tester.element(find.byType(MessageBubble));
      final theme = Theme.of(context);

      expect(
        receivedMessageText.style?.color,
        theme.colorScheme.onSurface,
      ); // Theme onSurface color
    });

    testWidgets('respects maximum width constraint', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageBubble(
              message: testMessage,
              isSentByCurrentUser: true,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(Flexible),
          matching: find.byType(Container),
        ),
      );

      // Verify the container has max width constraint
      expect(container.constraints?.maxWidth, isNotNull);
    });
  });
}

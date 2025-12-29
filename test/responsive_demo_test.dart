import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clone_messagers/utils/responsive_utils.dart';
import 'package:clone_messagers/widgets/message_bubble.dart';
import 'package:clone_messagers/models/message.dart';

void main() {
  group('Responsive Design Tests', () {
    testWidgets('MessageBubble should render with responsive constraints', (
      WidgetTester tester,
    ) async {
      // Create a test message
      final message = Message(
        id: '1',
        content:
            'This is a test message that should wrap properly on different screen sizes and demonstrate responsive behavior.',
        senderId: 'user1',
        timestamp: DateTime.now(),
        isRead: true,
      );

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageBubble(message: message, isSentByCurrentUser: true),
          ),
        ),
      );

      // Verify the message bubble renders
      expect(find.text(message.content), findsOneWidget);
      expect(find.byType(MessageBubble), findsOneWidget);
    });

    testWidgets('ResponsiveUtils methods should not throw errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Test that all responsive utility methods work without throwing
              final isMobile = ResponsiveUtils.isMobile(context);
              final isTablet = ResponsiveUtils.isTablet(context);
              final isDesktop = ResponsiveUtils.isDesktop(context);
              final padding = ResponsiveUtils.getResponsivePadding(context);
              final maxWidth = ResponsiveUtils.getMessageBubbleMaxWidth(
                context,
              );
              final fontSize = ResponsiveUtils.getResponsiveFontSize(
                context,
                16.0,
              );
              final avatarSize = ResponsiveUtils.getAvatarSize(context);
              final tileHeight = ResponsiveUtils.getConversationTileHeight(
                context,
              );
              final spacing = ResponsiveUtils.getMessageSpacing(context);
              final keyboardHeight = ResponsiveUtils.getKeyboardHeight(context);

              // Verify that exactly one screen type is true
              final screenTypes = [isMobile, isTablet, isDesktop];
              final trueCount = screenTypes.where((type) => type).length;
              expect(
                trueCount,
                equals(1),
                reason: 'Exactly one screen type should be true',
              );

              // Verify that values are reasonable
              expect(maxWidth, greaterThan(0));
              expect(fontSize, greaterThan(0));
              expect(avatarSize, greaterThan(0));
              expect(tileHeight, greaterThan(0));
              expect(spacing, greaterThanOrEqualTo(0));
              expect(keyboardHeight, greaterThanOrEqualTo(0));

              return Container(
                padding: padding,
                child: Text(
                  'Screen type: ${isMobile
                      ? 'Mobile'
                      : isTablet
                      ? 'Tablet'
                      : 'Desktop'}',
                ),
              );
            },
          ),
        ),
      );

      // Verify the widget builds successfully
      expect(find.byType(Container), findsOneWidget);
      expect(find.textContaining('Screen type:'), findsOneWidget);
    });
  });
}

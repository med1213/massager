import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clone_messagers/providers/providers.dart';
import 'package:clone_messagers/models/models.dart';

void main() {
  group('ConversationProvider Tests', () {
    test('should load conversations on initialization', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final conversations = container.read(conversationProvider);

      expect(conversations, isNotEmpty);
      expect(conversations.first, isA<Conversation>());
    });

    test('should sort conversations by most recent activity', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final conversations = container.read(conversationProvider);

      // Verify conversations are sorted by most recent activity
      for (int i = 0; i < conversations.length - 1; i++) {
        expect(
          conversations[i].lastMessageTime.isAfter(
                conversations[i + 1].lastMessageTime,
              ) ||
              conversations[i].lastMessageTime.isAtSameMomentAs(
                conversations[i + 1].lastMessageTime,
              ),
          isTrue,
          reason: 'Conversations should be sorted by most recent activity',
        );
      }
    });

    test('should update conversation metadata when adding message', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(conversationProvider.notifier);
      final initialConversations = container.read(conversationProvider);
      final testConversationId = initialConversations.first.id;

      final newMessage = Message(
        id: 'test_msg',
        content: 'Test message',
        senderId: 'test_user',
        timestamp: DateTime.now(),
        isRead: false,
        type: MessageType.text,
      );

      notifier.addMessageToConversation(testConversationId, newMessage);

      final updatedConversations = container.read(conversationProvider);
      final updatedConversation = updatedConversations.firstWhere(
        (conv) => conv.id == testConversationId,
      );

      expect(updatedConversation.lastMessage, equals('Test message'));
      expect(updatedConversation.unreadCount, greaterThan(0));
    });
  });

  group('MessagesProvider Tests', () {
    test('should load messages for conversation', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Get a conversation ID from the conversation provider
      final conversations = container.read(conversationProvider);
      final testConversationId = conversations.first.id;

      final messages = container.read(messagesProvider(testConversationId));

      expect(messages, isA<List<Message>>());
    });

    test('should sort messages chronologically', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final conversations = container.read(conversationProvider);
      final testConversationId = conversations.first.id;

      final messages = container.read(messagesProvider(testConversationId));

      if (messages.length > 1) {
        // Verify messages are sorted chronologically (oldest first)
        for (int i = 0; i < messages.length - 1; i++) {
          expect(
            messages[i].timestamp.isBefore(messages[i + 1].timestamp) ||
                messages[i].timestamp.isAtSameMomentAs(
                  messages[i + 1].timestamp,
                ),
            isTrue,
            reason: 'Messages should be sorted chronologically',
          );
        }
      }
    });

    test('should add new message and maintain chronological order', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final conversations = container.read(conversationProvider);
      final testConversationId = conversations.first.id;

      final notifier = container.read(
        messagesProvider(testConversationId).notifier,
      );
      final initialMessages = container.read(
        messagesProvider(testConversationId),
      );

      notifier.sendMessage('Test message from user');

      final updatedMessages = container.read(
        messagesProvider(testConversationId),
      );

      expect(updatedMessages.length, equals(initialMessages.length + 1));
      expect(updatedMessages.last.content, equals('Test message from user'));

      // Verify chronological order is maintained
      if (updatedMessages.length > 1) {
        for (int i = 0; i < updatedMessages.length - 1; i++) {
          expect(
            updatedMessages[i].timestamp.isBefore(
                  updatedMessages[i + 1].timestamp,
                ) ||
                updatedMessages[i].timestamp.isAtSameMomentAs(
                  updatedMessages[i + 1].timestamp,
                ),
            isTrue,
            reason:
                'Messages should remain in chronological order after adding new message',
          );
        }
      }
    });
  });
}

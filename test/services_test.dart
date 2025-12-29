import 'package:flutter_test/flutter_test.dart';
import 'package:clone_messagers/services/services.dart';

void main() {
  group('SampleDataRepository Tests', () {
    late SampleDataRepository repository;

    setUp(() {
      repository = SampleDataRepository();
    });

    test('should return sample conversations', () {
      final conversations = repository.getConversations();

      expect(conversations, isNotEmpty);
      expect(conversations.length, greaterThan(0));

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
          reason:
              'Conversations should be sorted by most recent activity first',
        );
      }

      // Verify conversation structure
      final firstConversation = conversations.first;
      expect(firstConversation.id, isNotEmpty);
      expect(firstConversation.title, isNotEmpty);
      expect(firstConversation.lastMessage, isNotEmpty);
      expect(firstConversation.participantIds, isNotEmpty);
      expect(firstConversation.participantIds, contains('current_user'));
    });

    test('should return messages for specific conversation', () {
      final conversations = repository.getConversations();
      expect(conversations, isNotEmpty);

      final conversationId = conversations.first.id;
      final messages = repository.getMessagesForConversation(conversationId);

      expect(messages, isNotEmpty);

      // Verify messages are in chronological order
      for (int i = 0; i < messages.length - 1; i++) {
        expect(
          messages[i].timestamp.isBefore(messages[i + 1].timestamp) ||
              messages[i].timestamp.isAtSameMomentAs(messages[i + 1].timestamp),
          isTrue,
          reason: 'Messages should be in chronological order',
        );
      }

      // Verify message structure
      final firstMessage = messages.first;
      expect(firstMessage.id, isNotEmpty);
      expect(firstMessage.content, isNotEmpty);
      expect(firstMessage.senderId, isNotEmpty);
    });

    test('should return empty list for non-existent conversation', () {
      final messages = repository.getMessagesForConversation('non_existent_id');
      expect(messages, isEmpty);
    });

    test('should return sample contacts', () {
      final contacts = repository.getContacts();

      expect(contacts, isNotEmpty);
      expect(contacts.length, greaterThan(0));

      // Verify contact structure
      final firstContact = contacts.first;
      expect(firstContact.id, isNotEmpty);
      expect(firstContact.name, isNotEmpty);
      expect(firstContact.isOnline, isA<bool>());
    });

    test('should return specific contact by ID', () {
      final contacts = repository.getContacts();
      expect(contacts, isNotEmpty);

      final contactId = contacts.first.id;
      final contact = repository.getContactById(contactId);

      expect(contact, isNotNull);
      expect(contact!.id, equals(contactId));
    });

    test('should return null for non-existent contact', () {
      final contact = repository.getContactById('non_existent_id');
      expect(contact, isNull);
    });

    test('should return specific conversation by ID', () {
      final conversations = repository.getConversations();
      expect(conversations, isNotEmpty);

      final conversationId = conversations.first.id;
      final conversation = repository.getConversationById(conversationId);

      expect(conversation, isNotNull);
      expect(conversation!.id, equals(conversationId));
    });

    test('should return null for non-existent conversation', () {
      final conversation = repository.getConversationById('non_existent_id');
      expect(conversation, isNull);
    });

    test('should return current user ID', () {
      final currentUserId = repository.getCurrentUserId();
      expect(currentUserId, equals('current_user'));
    });

    test('should have realistic sample data', () {
      final conversations = repository.getConversations();
      final contacts = repository.getContacts();

      // Verify we have some conversations with unread messages
      final unreadConversations = conversations.where((c) => c.unreadCount > 0);
      expect(unreadConversations, isNotEmpty);

      // Verify we have both online and offline contacts
      final onlineContacts = contacts.where((c) => c.isOnline);
      final offlineContacts = contacts.where((c) => !c.isOnline);
      expect(onlineContacts, isNotEmpty);
      expect(offlineContacts, isNotEmpty);

      // Verify conversations have messages
      for (final conversation in conversations.take(3)) {
        final messages = repository.getMessagesForConversation(conversation.id);
        expect(
          messages,
          isNotEmpty,
          reason: 'Conversation ${conversation.id} should have messages',
        );
      }
    });

    test('should have consistent data relationships', () {
      final conversations = repository.getConversations();
      final contacts = repository.getContacts();
      final contactIds = contacts.map((c) => c.id).toSet();

      for (final conversation in conversations) {
        // Check that participant IDs (except current_user) exist in contacts
        final nonCurrentUserParticipants = conversation.participantIds.where(
          (id) => id != 'current_user',
        );

        for (final participantId in nonCurrentUserParticipants) {
          expect(
            contactIds.contains(participantId),
            isTrue,
            reason: 'Participant $participantId should exist in contacts',
          );
        }

        // Check that messages exist for this conversation
        final messages = repository.getMessagesForConversation(conversation.id);
        if (messages.isNotEmpty) {
          // Verify last message matches conversation's last message
          final lastMessage = messages.last;
          expect(conversation.lastMessage, equals(lastMessage.content));
          expect(conversation.lastMessageTime, equals(lastMessage.timestamp));
        }
      }
    });
  });
}

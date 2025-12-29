import 'package:flutter_test/flutter_test.dart';
import 'package:clone_messagers/models/models.dart';

void main() {
  group('Message Model Tests', () {
    test('should create Message with all required fields', () {
      final timestamp = DateTime.now();
      final message = Message(
        id: '1',
        content: 'Hello World',
        senderId: 'user1',
        timestamp: timestamp,
        isRead: false,
      );

      expect(message.id, '1');
      expect(message.content, 'Hello World');
      expect(message.senderId, 'user1');
      expect(message.timestamp, timestamp);
      expect(message.isRead, false);
      expect(message.type, MessageType.text);
    });

    test('should serialize to and from JSON correctly', () {
      final timestamp = DateTime.now();
      final message = Message(
        id: '1',
        content: 'Hello World',
        senderId: 'user1',
        timestamp: timestamp,
        isRead: true,
        type: MessageType.text,
      );

      final json = message.toJson();
      final deserializedMessage = Message.fromJson(json);

      expect(deserializedMessage, equals(message));
    });

    test('should support copyWith functionality', () {
      final message = Message(
        id: '1',
        content: 'Hello World',
        senderId: 'user1',
        timestamp: DateTime.now(),
        isRead: false,
      );

      final updatedMessage = message.copyWith(isRead: true);

      expect(updatedMessage.isRead, true);
      expect(updatedMessage.id, message.id);
      expect(updatedMessage.content, message.content);
    });
  });

  group('Conversation Model Tests', () {
    test('should create Conversation with all required fields', () {
      final lastMessageTime = DateTime.now();
      final conversation = Conversation(
        id: 'conv1',
        title: 'John Doe',
        lastMessage: 'Hey there!',
        lastMessageTime: lastMessageTime,
        unreadCount: 2,
        participantIds: ['user1', 'user2'],
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      expect(conversation.id, 'conv1');
      expect(conversation.title, 'John Doe');
      expect(conversation.lastMessage, 'Hey there!');
      expect(conversation.lastMessageTime, lastMessageTime);
      expect(conversation.unreadCount, 2);
      expect(conversation.participantIds, ['user1', 'user2']);
      expect(conversation.avatarUrl, 'https://example.com/avatar.jpg');
    });

    test('should serialize to and from JSON correctly', () {
      final lastMessageTime = DateTime.now();
      final conversation = Conversation(
        id: 'conv1',
        title: 'John Doe',
        lastMessage: 'Hey there!',
        lastMessageTime: lastMessageTime,
        unreadCount: 2,
        participantIds: ['user1', 'user2'],
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      final json = conversation.toJson();
      final deserializedConversation = Conversation.fromJson(json);

      expect(deserializedConversation, equals(conversation));
    });

    test('should support copyWith functionality', () {
      final conversation = Conversation(
        id: 'conv1',
        title: 'John Doe',
        lastMessage: 'Hey there!',
        lastMessageTime: DateTime.now(),
        unreadCount: 2,
        participantIds: ['user1', 'user2'],
      );

      final updatedConversation = conversation.copyWith(unreadCount: 0);

      expect(updatedConversation.unreadCount, 0);
      expect(updatedConversation.id, conversation.id);
      expect(updatedConversation.title, conversation.title);
    });
  });

  group('Contact Model Tests', () {
    test('should create Contact with all required fields', () {
      final contact = Contact(
        id: 'contact1',
        name: 'Jane Smith',
        avatarUrl: 'https://example.com/jane.jpg',
        isOnline: true,
      );

      expect(contact.id, 'contact1');
      expect(contact.name, 'Jane Smith');
      expect(contact.avatarUrl, 'https://example.com/jane.jpg');
      expect(contact.isOnline, true);
    });

    test('should serialize to and from JSON correctly', () {
      final contact = Contact(
        id: 'contact1',
        name: 'Jane Smith',
        avatarUrl: 'https://example.com/jane.jpg',
        isOnline: false,
      );

      final json = contact.toJson();
      final deserializedContact = Contact.fromJson(json);

      expect(deserializedContact, equals(contact));
    });

    test('should support copyWith functionality', () {
      final contact = Contact(
        id: 'contact1',
        name: 'Jane Smith',
        isOnline: false,
      );

      final updatedContact = contact.copyWith(isOnline: true);

      expect(updatedContact.isOnline, true);
      expect(updatedContact.id, contact.id);
      expect(updatedContact.name, contact.name);
    });

    test('should handle null avatarUrl', () {
      final contact = Contact(
        id: 'contact1',
        name: 'Jane Smith',
        isOnline: true,
      );

      expect(contact.avatarUrl, isNull);

      final json = contact.toJson();
      final deserializedContact = Contact.fromJson(json);

      expect(deserializedContact.avatarUrl, isNull);
      expect(deserializedContact, equals(contact));
    });
  });
}

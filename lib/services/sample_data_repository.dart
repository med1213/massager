import '../models/models.dart';

/// Repository that provides sample data for demonstration purposes
class SampleDataRepository {
  static const String _currentUserId = 'current_user';

  /// Sample contacts with realistic names and online status
  static final List<Contact> _sampleContacts = [
    Contact(id: 'john_doe', name: 'John Doe', avatarUrl: null, isOnline: true),
    Contact(
      id: 'jane_smith',
      name: 'Jane Smith',
      avatarUrl: null,
      isOnline: false,
    ),
    Contact(
      id: 'mike_johnson',
      name: 'Mike Johnson',
      avatarUrl: null,
      isOnline: true,
    ),
    Contact(
      id: 'sarah_wilson',
      name: 'Sarah Wilson',
      avatarUrl: null,
      isOnline: true,
    ),
    Contact(
      id: 'alex_brown',
      name: 'Alex Brown',
      avatarUrl: null,
      isOnline: false,
    ),
    Contact(
      id: 'emma_davis',
      name: 'Emma Davis',
      avatarUrl: null,
      isOnline: true,
    ),
    Contact(
      id: 'team_chat',
      name: 'Team Chat',
      avatarUrl: null,
      isOnline: true,
    ),
  ];

  /// Sample messages for each conversation
  static final Map<String, List<Message>> _sampleMessages = {
    'conv_john': [
      Message(
        id: 'msg_1',
        content: 'Hey! How are you doing?',
        senderId: 'john_doe',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: 'msg_2',
        content: 'I\'m doing great, thanks for asking! How about you?',
        senderId: _currentUserId,
        timestamp: DateTime.now().subtract(
          const Duration(hours: 1, minutes: 55),
        ),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: 'msg_3',
        content: 'Pretty good! Are we still on for lunch tomorrow?',
        senderId: 'john_doe',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: false,
        type: MessageType.text,
      ),
      Message(
        id: 'msg_4',
        content: 'Absolutely! Looking forward to it.',
        senderId: 'john_doe',
        timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
        isRead: false,
        type: MessageType.text,
      ),
    ],
    'conv_jane': [
      Message(
        id: 'msg_5',
        content: 'Did you see the presentation slides I sent?',
        senderId: 'jane_smith',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: 'msg_6',
        content: 'Yes, they look great! I have a few suggestions.',
        senderId: _currentUserId,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: 'msg_7',
        content: 'Perfect, let\'s discuss them in tomorrow\'s meeting.',
        senderId: 'jane_smith',
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        isRead: true,
        type: MessageType.text,
      ),
    ],
    'conv_mike': [
      Message(
        id: 'msg_8',
        content: 'The game last night was incredible!',
        senderId: 'mike_johnson',
        timestamp: DateTime.now().subtract(const Duration(hours: 12)),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: 'msg_9',
        content: 'I know right! That last-minute goal was amazing.',
        senderId: _currentUserId,
        timestamp: DateTime.now().subtract(
          const Duration(hours: 11, minutes: 45),
        ),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: 'msg_10',
        content: 'Want to catch the next game together?',
        senderId: 'mike_johnson',
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        isRead: true,
        type: MessageType.text,
      ),
    ],
    'conv_sarah': [
      Message(
        id: 'msg_11',
        content: 'Happy birthday! 🎉',
        senderId: 'sarah_wilson',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: 'msg_12',
        content: 'Thank you so much! 😊',
        senderId: _currentUserId,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 23)),
        isRead: true,
        type: MessageType.text,
      ),
    ],
    'conv_alex': [
      Message(
        id: 'msg_13',
        content: 'Can you help me with the project setup?',
        senderId: 'alex_brown',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: 'msg_14',
        content: 'Sure! I\'ll send you the documentation.',
        senderId: _currentUserId,
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 22)),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: 'msg_15',
        content: 'Thanks! That would be really helpful.',
        senderId: 'alex_brown',
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 20)),
        isRead: true,
        type: MessageType.text,
      ),
    ],
    'conv_emma': [
      Message(
        id: 'msg_16',
        content: 'Coffee later?',
        senderId: 'emma_davis',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        isRead: false,
        type: MessageType.text,
      ),
    ],
    'conv_team': [
      Message(
        id: 'msg_17',
        content: 'Good morning team! Don\'t forget about the standup at 10 AM.',
        senderId: 'jane_smith',
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: 'msg_18',
        content: 'Thanks for the reminder!',
        senderId: 'mike_johnson',
        timestamp: DateTime.now().subtract(
          const Duration(hours: 7, minutes: 45),
        ),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: 'msg_19',
        content: 'I\'ll be there.',
        senderId: _currentUserId,
        timestamp: DateTime.now().subtract(
          const Duration(hours: 7, minutes: 30),
        ),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: 'msg_20',
        content: 'Great! See everyone then.',
        senderId: 'sarah_wilson',
        timestamp: DateTime.now().subtract(const Duration(hours: 7)),
        isRead: true,
        type: MessageType.text,
      ),
    ],
  };

  /// Returns all sample conversations sorted by most recent activity
  List<Conversation> getConversations() {
    final conversations = <Conversation>[];

    // Build conversations from messages to ensure consistency
    for (final entry in _sampleMessages.entries) {
      final conversationId = entry.key;
      final messages = entry.value;

      if (messages.isEmpty) continue;

      final lastMessage = messages.last;
      final contact = getContactById(
        _getContactIdFromConversationId(conversationId),
      );
      final title =
          contact?.name ?? _getTitleFromConversationId(conversationId);

      final unreadCount = messages
          .where((m) => !m.isRead && m.senderId != _currentUserId)
          .length;

      final participantIds = conversationId == 'conv_team'
          ? [_currentUserId, 'jane_smith', 'mike_johnson', 'sarah_wilson']
          : [_currentUserId, _getContactIdFromConversationId(conversationId)];

      conversations.add(
        Conversation(
          id: conversationId,
          title: title,
          lastMessage: lastMessage.content,
          lastMessageTime: lastMessage.timestamp,
          unreadCount: unreadCount,
          participantIds: participantIds,
          avatarUrl: null,
        ),
      );
    }

    // Sort by most recent activity
    conversations.sort(
      (a, b) => b.lastMessageTime.compareTo(a.lastMessageTime),
    );
    return conversations;
  }

  /// Returns messages for a specific conversation
  List<Message> getMessagesForConversation(String conversationId) {
    return List.from(_sampleMessages[conversationId] ?? []);
  }

  /// Add a new message to a conversation
  void addMessageToConversation(String conversationId, Message message) {
    if (_sampleMessages[conversationId] == null) {
      _sampleMessages[conversationId] = [];
    }
    _sampleMessages[conversationId]!.add(message);
  }

  /// Returns all sample contacts
  List<Contact> getContacts() {
    return List.from(_sampleContacts);
  }

  /// Returns a specific contact by ID
  Contact? getContactById(String contactId) {
    try {
      return _sampleContacts.firstWhere((contact) => contact.id == contactId);
    } catch (e) {
      return null;
    }
  }

  /// Returns a specific conversation by ID
  Conversation? getConversationById(String conversationId) {
    final conversations = getConversations();
    try {
      return conversations.firstWhere((conv) => conv.id == conversationId);
    } catch (e) {
      return null;
    }
  }

  /// Returns the current user ID
  String getCurrentUserId() {
    return _currentUserId;
  }

  /// Helper method to get contact ID from conversation ID
  String _getContactIdFromConversationId(String conversationId) {
    switch (conversationId) {
      case 'conv_john':
        return 'john_doe';
      case 'conv_jane':
        return 'jane_smith';
      case 'conv_mike':
        return 'mike_johnson';
      case 'conv_sarah':
        return 'sarah_wilson';
      case 'conv_alex':
        return 'alex_brown';
      case 'conv_emma':
        return 'emma_davis';
      case 'conv_team':
        return 'team_chat';
      default:
        return conversationId.replaceFirst('conv_', '');
    }
  }

  /// Helper method to get title from conversation ID
  String _getTitleFromConversationId(String conversationId) {
    switch (conversationId) {
      case 'conv_john':
        return 'John Doe';
      case 'conv_jane':
        return 'Jane Smith';
      case 'conv_mike':
        return 'Mike Johnson';
      case 'conv_sarah':
        return 'Sarah Wilson';
      case 'conv_alex':
        return 'Alex Brown';
      case 'conv_emma':
        return 'Emma Davis';
      case 'conv_team':
        return 'Team Chat';
      default:
        return conversationId.replaceFirst('conv_', '').replaceAll('_', ' ');
    }
  }
}

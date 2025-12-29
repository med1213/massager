import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/services.dart';
import '../config/app_config.dart';
import 'conversation_provider.dart';

/// State notifier for managing messages in a specific conversation
class MessagesNotifier extends StateNotifier<List<Message>> {
  MessagesNotifier(this._conversationId, this._repository, this._ref)
    : super([]) {
    loadMessages();
  }

  final String _conversationId;
  final SampleDataRepository _repository;
  final Ref _ref;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// Load messages for the conversation and sort chronologically
  Future<void> loadMessages() async {
    _isLoading = true;

    // Simulate network delay for demonstration (configurable)
    if (AppConfig.enableLoadingDelays) {
      await Future.delayed(
        Duration(milliseconds: AppConfig.messageLoadingDelay),
      );
    }

    final messages = _repository.getMessagesForConversation(_conversationId);
    // Sort messages chronologically (oldest first)
    messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    state = messages;

    _isLoading = false;
  }

  /// Add a new message to the conversation
  void addMessage(Message message) {
    // Add message to repository for persistence
    _repository.addMessageToConversation(_conversationId, message);

    // Add message to state
    final updatedMessages = [...state, message];
    // Keep chronological order
    updatedMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    state = updatedMessages;

    // Update the conversation metadata through the conversation provider
    _ref
        .read(conversationProvider.notifier)
        .addMessageToConversation(_conversationId, message);
  }

  /// Send a new message (convenience method for adding user messages)
  void sendMessage(String content) {
    final message = Message(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      content: content,
      senderId: _repository.getCurrentUserId(),
      timestamp: DateTime.now(),
      isRead: true, // User's own messages are always read
      type: MessageType.text,
    );

    addMessage(message);
  }

  /// Mark all messages in the conversation as read
  void markAllMessagesAsRead() {
    final updatedMessages = state.map((message) {
      return message.copyWith(isRead: true);
    }).toList();
    state = updatedMessages;

    // Update conversation unread count
    _ref
        .read(conversationProvider.notifier)
        .markConversationAsRead(_conversationId);
  }

  /// Mark a specific message as read
  void markMessageAsRead(String messageId) {
    final updatedMessages = state.map((message) {
      if (message.id == messageId) {
        return message.copyWith(isRead: true);
      }
      return message;
    }).toList();
    state = updatedMessages;
  }

  /// Get the latest message in the conversation
  Message? getLatestMessage() {
    if (state.isEmpty) return null;
    return state.last;
  }

  /// Get unread messages count for current user
  int getUnreadCount() {
    return state
        .where(
          (message) =>
              !message.isRead &&
              message.senderId != _repository.getCurrentUserId(),
        )
        .length;
  }

  /// Refresh messages from repository
  Future<void> refresh() async {
    await loadMessages();
  }
}

/// Provider for messages state management (family provider for conversation-specific messages)
final messagesProvider =
    StateNotifierProvider.family<MessagesNotifier, List<Message>, String>(
      (ref, conversationId) =>
          MessagesNotifier(conversationId, SampleDataRepository(), ref),
    );

/// Provider for checking if messages are loading for a specific conversation
final isLoadingMessagesProvider = Provider.family<bool, String>((
  ref,
  conversationId,
) {
  final notifier = ref.read(messagesProvider(conversationId).notifier);
  return notifier.isLoading;
});

/// Provider for getting the latest message in a conversation
final latestMessageProvider = Provider.family<Message?, String>((
  ref,
  conversationId,
) {
  final messages = ref.watch(messagesProvider(conversationId));
  return messages.isEmpty ? null : messages.last;
});

/// Provider for getting unread message count for a conversation
final unreadMessageCountProvider = Provider.family<int, String>((
  ref,
  conversationId,
) {
  final messages = ref.watch(messagesProvider(conversationId));
  final currentUserId = SampleDataRepository().getCurrentUserId();
  return messages
      .where((message) => !message.isRead && message.senderId != currentUserId)
      .length;
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/services.dart';
import '../config/app_config.dart';

/// State notifier for managing conversation list
class ConversationNotifier extends StateNotifier<List<Conversation>> {
  ConversationNotifier(this._repository) : super([]) {
    loadConversations();
  }

  final SampleDataRepository _repository;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// Load conversations from repository and sort by most recent activity
  Future<void> loadConversations() async {
    _isLoading = true;

    // Simulate network delay for demonstration (configurable)
    if (AppConfig.enableLoadingDelays) {
      await Future.delayed(
        Duration(milliseconds: AppConfig.conversationLoadingDelay),
      );
    }

    final conversations = _repository.getConversations();
    state = conversations;

    _isLoading = false;
  }

  /// Update a conversation with new message information
  void updateConversation(
    String conversationId, {
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
  }) {
    state = state.map((conversation) {
      if (conversation.id == conversationId) {
        return conversation.copyWith(
          lastMessage: lastMessage ?? conversation.lastMessage,
          lastMessageTime: lastMessageTime ?? conversation.lastMessageTime,
          unreadCount: unreadCount ?? conversation.unreadCount,
        );
      }
      return conversation;
    }).toList();

    // Re-sort conversations by most recent activity
    _sortConversationsByMostRecent();
  }

  /// Mark a conversation as read (set unread count to 0)
  void markConversationAsRead(String conversationId) {
    updateConversation(conversationId, unreadCount: 0);
  }

  /// Add a new message to a conversation and update its metadata
  void addMessageToConversation(String conversationId, Message message) {
    // Update conversation with new message info
    updateConversation(
      conversationId,
      lastMessage: message.content,
      lastMessageTime: message.timestamp,
      unreadCount: message.senderId != _repository.getCurrentUserId()
          ? (getConversationById(conversationId)?.unreadCount ?? 0) + 1
          : 0,
    );
  }

  /// Get a specific conversation by ID
  Conversation? getConversationById(String conversationId) {
    try {
      return state.firstWhere((conv) => conv.id == conversationId);
    } catch (e) {
      return null;
    }
  }

  /// Sort conversations by most recent activity (private helper)
  void _sortConversationsByMostRecent() {
    final sortedConversations = List<Conversation>.from(state);
    sortedConversations.sort(
      (a, b) => b.lastMessageTime.compareTo(a.lastMessageTime),
    );
    state = sortedConversations;
  }

  /// Refresh conversations from repository
  Future<void> refresh() async {
    await loadConversations();
  }
}

/// Provider for conversation state management
final conversationProvider =
    StateNotifierProvider<ConversationNotifier, List<Conversation>>(
      (ref) => ConversationNotifier(SampleDataRepository()),
    );

/// Provider for checking if conversations are loading
final isLoadingConversationsProvider = Provider<bool>((ref) {
  final notifier = ref.read(conversationProvider.notifier);
  return notifier.isLoading;
});

/// Provider for getting a specific conversation by ID
final conversationByIdProvider = Provider.family<Conversation?, String>((
  ref,
  conversationId,
) {
  final conversations = ref.watch(conversationProvider);
  try {
    return conversations.firstWhere((conv) => conv.id == conversationId);
  } catch (e) {
    return null;
  }
});

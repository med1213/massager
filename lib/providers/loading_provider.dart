import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Loading state for different parts of the app
class LoadingState {
  final bool isLoadingConversations;
  final bool isLoadingMessages;
  final Map<String, bool> isLoadingMessagesForConversation;

  const LoadingState({
    this.isLoadingConversations = false,
    this.isLoadingMessages = false,
    this.isLoadingMessagesForConversation = const {},
  });

  LoadingState copyWith({
    bool? isLoadingConversations,
    bool? isLoadingMessages,
    Map<String, bool>? isLoadingMessagesForConversation,
  }) {
    return LoadingState(
      isLoadingConversations:
          isLoadingConversations ?? this.isLoadingConversations,
      isLoadingMessages: isLoadingMessages ?? this.isLoadingMessages,
      isLoadingMessagesForConversation:
          isLoadingMessagesForConversation ??
          this.isLoadingMessagesForConversation,
    );
  }

  /// Check if messages are loading for a specific conversation
  bool isLoadingMessagesFor(String conversationId) {
    return isLoadingMessagesForConversation[conversationId] ?? false;
  }
}

/// State notifier for managing loading states
class LoadingNotifier extends StateNotifier<LoadingState> {
  LoadingNotifier() : super(const LoadingState());

  /// Set conversations loading state
  void setConversationsLoading(bool isLoading) {
    state = state.copyWith(isLoadingConversations: isLoading);
  }

  /// Set messages loading state for a specific conversation
  void setMessagesLoading(String conversationId, bool isLoading) {
    final updatedMap = Map<String, bool>.from(
      state.isLoadingMessagesForConversation,
    );
    updatedMap[conversationId] = isLoading;
    state = state.copyWith(isLoadingMessagesForConversation: updatedMap);
  }

  /// Set general messages loading state
  void setGeneralMessagesLoading(bool isLoading) {
    state = state.copyWith(isLoadingMessages: isLoading);
  }
}

/// Provider for loading state management
final loadingProvider = StateNotifierProvider<LoadingNotifier, LoadingState>(
  (ref) => LoadingNotifier(),
);

/// Provider for checking if conversations are loading
final isLoadingConversationsProvider = Provider<bool>((ref) {
  return ref.watch(loadingProvider).isLoadingConversations;
});

/// Provider for checking if messages are loading for a specific conversation
final isLoadingMessagesProvider = Provider.family<bool, String>((
  ref,
  conversationId,
) {
  return ref.watch(loadingProvider).isLoadingMessagesFor(conversationId);
});

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import '../utils/responsive_utils.dart';
import '../theme/messenger_theme.dart';

/// Chat screen for viewing and sending messages in a conversation
class ChatScreen extends ConsumerStatefulWidget {
  final String conversationId;

  const ChatScreen({super.key, required this.conversationId});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final SampleDataRepository _repository = SampleDataRepository();

  @override
  void initState() {
    super.initState();
    // Auto-scroll to latest message when chat loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    // Save current screen and conversation ID
    WidgetsBinding.instance.addPostFrameCallback((_) {
      StatePersistenceService.saveLastViewedScreen(
        '/chat/${widget.conversationId}',
      );
      StatePersistenceService.saveLastViewedConversationId(
        widget.conversationId,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Scroll to the bottom of the message list with animation
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  /// Scroll to bottom immediately without animation (for initial load)
  void _scrollToBottomInstant() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  /// Get the conversation title for the app bar
  String _getConversationTitle() {
    final conversation = _repository.getConversationById(widget.conversationId);
    return conversation?.title ?? 'Chat';
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesProvider(widget.conversationId));
    final isLoadingMessages = ref.watch(
      isLoadingMessagesProvider(widget.conversationId),
    );
    final currentUserId = _repository.getCurrentUserId();
    final theme = Theme.of(context);

    // Listen for new messages and auto-scroll when messages are added
    ref.listen<List<Message>>(messagesProvider(widget.conversationId), (
      previous,
      current,
    ) {
      if (previous != null && current.length > previous.length) {
        // New message added, scroll to bottom with animation
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      } else if (previous == null && current.isNotEmpty) {
        // Initial load with messages, scroll to bottom instantly
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottomInstant();
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getConversationTitle(),
          style: theme.appBarTheme.titleTextStyle?.copyWith(
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18.0),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: ResponsiveUtils.isMobile(context) ? 24 : 28,
          ),
          onPressed: () => NavigationService.goBack(),
        ),
        elevation: ResponsiveUtils.isMobile(context) ? 1 : 2,
      ),
      body: Column(
        children: [
          // Message list
          Expanded(
            child: Container(
              color: theme.colorScheme.surface,
              child: isLoadingMessages
                  ? const ChatShimmer()
                  : messages.isEmpty
                  ? Center(
                      child: Text(
                        'No messages yet',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context,
                            16.0,
                          ),
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        return ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.symmetric(
                            vertical: ResponsiveUtils.isMobile(context)
                                ? MessengerTheme.spacingS
                                : MessengerTheme.spacingM,
                            horizontal: ResponsiveUtils.isMobile(context)
                                ? MessengerTheme.spacingS
                                : MessengerTheme.spacingL,
                          ),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final isSentByCurrentUser =
                                message.senderId == currentUserId;

                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: ResponsiveUtils.getMessageSpacing(
                                  context,
                                ),
                              ),
                              child: MessageBubble(
                                message: message,
                                isSentByCurrentUser: isSentByCurrentUser,
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ),
          // Message composer
          MessageComposer(conversationId: widget.conversationId),
        ],
      ),
      // Handle keyboard layout adjustments
      resizeToAvoidBottomInset: true,
    );
  }
}

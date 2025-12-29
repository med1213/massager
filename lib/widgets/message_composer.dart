import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../utils/responsive_utils.dart';
import '../theme/messenger_theme.dart';

/// Widget for composing and sending messages
class MessageComposer extends ConsumerStatefulWidget {
  final String conversationId;

  const MessageComposer({super.key, required this.conversationId});

  @override
  ConsumerState<MessageComposer> createState() => _MessageComposerState();
}

class _MessageComposerState extends ConsumerState<MessageComposer> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _textController.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    // Send the message through the provider
    ref
        .read(messagesProvider(widget.conversationId).notifier)
        .sendMessage(text);

    // Clear the input field and maintain focus
    _textController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final responsivePadding = ResponsiveUtils.getResponsivePadding(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsivePadding.horizontal,
        vertical: ResponsiveUtils.isMobile(context) ? 12 : 16,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.colorScheme.outline, width: 0.5),
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Adjust layout based on available width
            final isWideScreen =
                constraints.maxWidth > ResponsiveUtils.mobileBreakpoint;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Text input field
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: isWideScreen ? 120 : 100,
                    ),
                    child: TextField(
                      controller: _textController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context,
                            16.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            MessengerTheme.inputBorderRadius,
                          ),
                          borderSide: BorderSide(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            MessengerTheme.inputBorderRadius,
                          ),
                          borderSide: BorderSide(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            MessengerTheme.inputBorderRadius,
                          ),
                          borderSide: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.isMobile(context)
                              ? 16
                              : 20,
                          vertical: ResponsiveUtils.isMobile(context) ? 12 : 16,
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                      ),
                      style: TextStyle(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(
                          context,
                          16.0,
                        ),
                      ),
                      maxLines: ResponsiveUtils.isMobile(context) ? 4 : 6,
                      minLines: 1,
                      textCapitalization: TextCapitalization.sentences,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                SizedBox(width: ResponsiveUtils.isMobile(context) ? 8 : 12),
                // Send button
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: IconButton(
                    onPressed: _hasText ? _sendMessage : null,
                    icon: Icon(
                      Icons.send,
                      color: _hasText
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                      size: ResponsiveUtils.isMobile(context) ? 24 : 28,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: _hasText
                          ? theme.colorScheme.primary.withValues(alpha: 0.1)
                          : Colors.transparent,
                      shape: const CircleBorder(),
                      padding: EdgeInsets.all(
                        ResponsiveUtils.isMobile(context) ? 12 : 16,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/message.dart';
import '../utils/responsive_utils.dart';
import '../theme/messenger_theme.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isSentByCurrentUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isSentByCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: ResponsiveUtils.getMessageBubblePadding(context),
      child: Row(
        mainAxisAlignment: isSentByCurrentUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: ResponsiveUtils.getMessageBubbleMaxWidth(context),
              ),
              padding: EdgeInsets.symmetric(
                vertical: ResponsiveUtils.isMobile(context) ? 12.0 : 14.0,
                horizontal: ResponsiveUtils.isMobile(context) ? 16.0 : 18.0,
              ),
              decoration: isSentByCurrentUser
                  ? MessengerTheme.sentMessageDecoration
                  : MessengerTheme.receivedMessageDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.content,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: ResponsiveUtils.getResponsiveFontSize(
                        context,
                        16.0,
                      ),
                      color: isSentByCurrentUser
                          ? Colors.white
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.normal,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(
                    height: ResponsiveUtils.isMobile(context) ? 4.0 : 6.0,
                  ),
                  Text(
                    _formatTimestamp(message.timestamp),
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: ResponsiveUtils.getResponsiveFontSize(
                        context,
                        12.0,
                      ),
                      color: isSentByCurrentUser
                          ? Colors.white.withValues(alpha: 0.8)
                          : theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return DateFormat('MMM d').format(timestamp);
    } else if (difference.inHours > 0) {
      return DateFormat('h:mm a').format(timestamp);
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

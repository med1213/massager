import 'package:flutter/material.dart';
import '../models/models.dart';
import '../utils/responsive_utils.dart';

/// Widget that displays a single conversation in the conversation list
class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const ConversationTile({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasUnreadMessages = conversation.unreadCount > 0;
    final avatarSize = ResponsiveUtils.getAvatarSize(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
            width: 0.5,
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: ResponsiveUtils.getResponsivePadding(context).copyWith(
            top: ResponsiveUtils.isMobile(context) ? 16.0 : 20.0,
            bottom: ResponsiveUtils.isMobile(context) ? 16.0 : 20.0,
          ),
          constraints: BoxConstraints(
            minHeight: ResponsiveUtils.getConversationTileHeight(context),
          ),
          child: Row(
            children: [
              // Avatar placeholder
              CircleAvatar(
                radius: avatarSize,
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.1,
                ),
                backgroundImage: conversation.avatarUrl != null
                    ? NetworkImage(conversation.avatarUrl!)
                    : null,
                child: conversation.avatarUrl == null
                    ? Text(
                        _getInitials(conversation.title),
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context,
                            16.0,
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: ResponsiveUtils.isMobile(context) ? 12 : 16),
              // Conversation details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Contact name
                        Expanded(
                          child: Text(
                            conversation.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: hasUnreadMessages
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              fontSize: ResponsiveUtils.getResponsiveFontSize(
                                context,
                                16.0,
                              ),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        // Timestamp
                        Text(
                          _formatTimestamp(conversation.lastMessageTime),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: hasUnreadMessages
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                            fontWeight: hasUnreadMessages
                                ? FontWeight.w600
                                : FontWeight.normal,
                            fontSize: ResponsiveUtils.getResponsiveFontSize(
                              context,
                              12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ResponsiveUtils.isMobile(context) ? 4 : 6),
                    Row(
                      children: [
                        // Last message preview
                        Expanded(
                          child: Text(
                            conversation.lastMessage,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: hasUnreadMessages
                                  ? theme.colorScheme.onSurface
                                  : theme.colorScheme.onSurfaceVariant,
                              fontWeight: hasUnreadMessages
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                              fontSize: ResponsiveUtils.getResponsiveFontSize(
                                context,
                                14.0,
                              ),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: ResponsiveUtils.isMobile(context) ? 1 : 2,
                          ),
                        ),
                        // Unread message indicator
                        if (hasUnreadMessages) ...[
                          SizedBox(
                            width: ResponsiveUtils.isMobile(context) ? 8 : 12,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.isMobile(context)
                                  ? 6
                                  : 8,
                              vertical: ResponsiveUtils.isMobile(context)
                                  ? 2
                                  : 4,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(
                                ResponsiveUtils.isMobile(context) ? 10 : 12,
                              ),
                            ),
                            constraints: BoxConstraints(
                              minWidth: ResponsiveUtils.isMobile(context)
                                  ? 20
                                  : 24,
                              minHeight: ResponsiveUtils.isMobile(context)
                                  ? 20
                                  : 24,
                            ),
                            child: Text(
                              conversation.unreadCount > 99
                                  ? '99+'
                                  : conversation.unreadCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ResponsiveUtils.getResponsiveFontSize(
                                  context,
                                  12.0,
                                ),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Generate initials from a name for the avatar placeholder
  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.isEmpty) return '';

    if (words.length == 1) {
      return words[0].isNotEmpty ? words[0][0].toUpperCase() : '';
    }

    return (words[0].isNotEmpty ? words[0][0] : '') +
        (words[1].isNotEmpty ? words[1][0] : '');
  }

  /// Format timestamp for display in conversation list
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      // Today - show time
      final hour = timestamp.hour;
      final minute = timestamp.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
      return '$displayHour:$minute $period';
    } else if (difference.inDays == 1) {
      // Yesterday
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      // This week - show day name
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[timestamp.weekday - 1];
    } else {
      // Older - show date
      final month = timestamp.month.toString().padLeft(2, '0');
      final day = timestamp.day.toString().padLeft(2, '0');
      return '$month/$day/${timestamp.year}';
    }
  }
}

import 'package:flutter/material.dart';
import 'shimmer_loading.dart';

class MessageBubbleShimmer extends StatelessWidget {
  final bool isSentByCurrentUser;
  final double? width;

  const MessageBubbleShimmer({
    super.key,
    required this.isSentByCurrentUser,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bubbleWidth = width ?? (screenWidth * 0.7);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment: isSentByCurrentUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: bubbleWidth),
            child: Column(
              crossAxisAlignment: isSentByCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Message bubble shimmer
                ShimmerBox(
                  width:
                      bubbleWidth *
                      (0.6 +
                          (0.4 * (0.5 + 0.5))), // Random width between 60-100%
                  height: 48,
                  borderRadius: BorderRadius.circular(18),
                ),
                const SizedBox(height: 4),
                // Timestamp shimmer
                ShimmerLine(width: 60, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatShimmer extends StatelessWidget {
  final int messageCount;

  const ChatShimmer({super.key, this.messageCount = 6});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: messageCount,
      itemBuilder: (context, index) {
        // Alternate between sent and received messages
        final isSent = index % 3 != 0; // More received messages for variety
        return ShimmerLoading(
          isLoading: true,
          child: MessageBubbleShimmer(isSentByCurrentUser: isSent),
        );
      },
    );
  }
}

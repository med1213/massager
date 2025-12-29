import 'package:flutter/material.dart';
import 'shimmer_loading.dart';

class ConversationTileShimmer extends StatelessWidget {
  const ConversationTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Avatar shimmer
          const ShimmerCircle(size: 56),
          const SizedBox(width: 12),
          // Content shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Name shimmer
                    ShimmerLine(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 18,
                    ),
                    // Timestamp shimmer
                    ShimmerLine(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 14,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Last message shimmer
                ShimmerLine(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationListShimmer extends StatelessWidget {
  final int itemCount;

  const ConversationListShimmer({super.key, this.itemCount = 8});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return ShimmerLoading(
          isLoading: true,
          child: const ConversationTileShimmer(),
        );
      },
    );
  }
}

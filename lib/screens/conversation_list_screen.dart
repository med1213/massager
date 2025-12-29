import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import '../utils/responsive_utils.dart';
import '../config/app_config.dart';

/// Main screen displaying the list of conversations
class ConversationListScreen extends ConsumerStatefulWidget {
  const ConversationListScreen({super.key});

  @override
  ConsumerState<ConversationListScreen> createState() =>
      _ConversationListScreenState();
}

class _ConversationListScreenState
    extends ConsumerState<ConversationListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _restoreScrollPosition();
    _scrollController.addListener(_saveScrollPosition);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_saveScrollPosition);
    _scrollController.dispose();
    super.dispose();
  }

  /// Restore the saved scroll position
  void _restoreScrollPosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final savedPosition =
            StatePersistenceService.getConversationListScrollPosition();
        if (savedPosition > 0) {
          _scrollController.jumpTo(savedPosition);
        }
      }
    });
  }

  /// Save the current scroll position
  void _saveScrollPosition() {
    if (_scrollController.hasClients) {
      StatePersistenceService.saveConversationListScrollPosition(
        _scrollController.position.pixels,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final conversations = ref.watch(conversationProvider);
    final isLoading = ref.watch(isLoadingConversationsProvider);
    final theme = Theme.of(context);

    // Save current screen when building
    WidgetsBinding.instance.addPostFrameCallback((_) {
      StatePersistenceService.saveLastViewedScreen('/');
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messenger',
          style: theme.appBarTheme.titleTextStyle?.copyWith(
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 20.0),
          ),
        ),
        elevation: ResponsiveUtils.isMobile(context) ? 1 : 2,
        actions: AppConfig.showDebugFeatures
            ? [
                // Debug button to access shimmer demo
                IconButton(
                  icon: const Icon(Icons.animation),
                  tooltip: 'Shimmer Demo',
                  onPressed: () {
                    Navigator.pushNamed(context, '/shimmer-demo');
                  },
                ),
              ]
            : null,
      ),
      body: Container(
        color: theme.colorScheme.surfaceContainerHighest,
        child: isLoading
            ? const ConversationListShimmer()
            : conversations.isEmpty
            ? const Center(
                child: Text(
                  'No conversations yet',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  // For very wide screens, we might want to show conversations in a grid
                  final isVeryWideScreen =
                      constraints.maxWidth > ResponsiveUtils.desktopBreakpoint;

                  if (isVeryWideScreen && conversations.length > 10) {
                    // Grid layout for desktop with many conversations
                    return GridView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveUtils.isMobile(context)
                            ? 8.0
                            : 16.0,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 4.5,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = conversations[index];
                        return ConversationTile(
                          conversation: conversation,
                          onTap: () {
                            NavigationService.navigateToChat(conversation.id);
                          },
                        );
                      },
                    );
                  } else {
                    // Standard list layout
                    return ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveUtils.isMobile(context)
                            ? 8.0
                            : 16.0,
                      ),
                      itemCount: conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = conversations[index];
                        return ConversationTile(
                          conversation: conversation,
                          onTap: () {
                            NavigationService.navigateToChat(conversation.id);
                          },
                        );
                      },
                    );
                  }
                },
              ),
      ),
    );
  }
}

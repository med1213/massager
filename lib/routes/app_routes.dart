import 'package:flutter/material.dart';
import '../screens/screens.dart';
import '../demo/demo.dart';

/// Route names for the application
class AppRoutes {
  static const String conversationList = '/';
  static const String chat = '/chat';
  static const String shimmerDemo = '/shimmer-demo';

  /// Generate routes for the application
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case conversationList:
        return MaterialPageRoute(
          builder: (context) => const ConversationListScreen(),
          settings: settings,
        );

      case chat:
        // Handle chat route with conversation ID parameter
        final args = settings.arguments as Map<String, dynamic>?;
        final conversationId = args?['conversationId'] as String?;

        if (conversationId == null) {
          return _errorRoute('Missing conversation ID');
        }

        return MaterialPageRoute(
          builder: (context) => ChatScreen(conversationId: conversationId),
          settings: settings,
        );

      case shimmerDemo:
        return MaterialPageRoute(
          builder: (context) => const ShimmerDemo(),
          settings: settings,
        );

      default:
        // Handle dynamic chat routes like /chat/123
        if (settings.name?.startsWith('/chat/') == true) {
          final conversationId = settings.name!.split('/chat/')[1];
          if (conversationId.isNotEmpty) {
            return MaterialPageRoute(
              builder: (context) => ChatScreen(conversationId: conversationId),
              settings: settings,
            );
          }
        }
        return _errorRoute('Route not found: ${settings.name}');
    }
  }

  /// Create an error route for unknown routes
  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.conversationList,
                  (route) => false,
                ),
                child: const Text('Go to Conversations'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Service for handling navigation throughout the app
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Get the current context
  static BuildContext? get currentContext => navigatorKey.currentContext;

  /// Navigate to conversation list screen
  static Future<void> navigateToConversationList() async {
    await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/',
      (route) => false,
    );
  }

  /// Navigate to chat screen with conversation ID
  static Future<void> navigateToChat(String conversationId) async {
    await navigatorKey.currentState?.pushNamed('/chat/$conversationId');
  }

  /// Go back to previous screen
  static void goBack() {
    if (navigatorKey.currentState?.canPop() == true) {
      navigatorKey.currentState?.pop();
    }
  }

  /// Check if we can go back
  static bool canGoBack() {
    return navigatorKey.currentState?.canPop() == true;
  }

  /// Get current route name
  static String? getCurrentRouteName() {
    return ModalRoute.of(currentContext!)?.settings.name;
  }
}

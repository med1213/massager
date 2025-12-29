import 'package:flutter/material.dart';
import 'navigation_service.dart';
import 'state_persistence_service.dart';

/// Service for handling app lifecycle events and state persistence
class AppLifecycleService extends WidgetsBindingObserver {
  static final AppLifecycleService _instance = AppLifecycleService._internal();
  factory AppLifecycleService() => _instance;
  AppLifecycleService._internal();

  bool _isInitialized = false;

  /// Initialize the lifecycle service
  Future<void> initialize() async {
    if (!_isInitialized) {
      WidgetsBinding.instance.addObserver(this);
      await StatePersistenceService.initialize();
      _isInitialized = true;
    }
  }

  /// Dispose the lifecycle service
  void dispose() {
    if (_isInitialized) {
      WidgetsBinding.instance.removeObserver(this);
      _isInitialized = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        _saveCurrentState();
        break;
      case AppLifecycleState.detached:
        _saveCurrentState();
        break;
      case AppLifecycleState.resumed:
        // App resumed, could restore state if needed
        break;
      case AppLifecycleState.inactive:
        // App became inactive
        break;
      case AppLifecycleState.hidden:
        // App is hidden
        break;
    }
  }

  /// Save the current app state
  void _saveCurrentState() {
    final currentRoute = NavigationService.getCurrentRouteName();
    if (currentRoute != null) {
      StatePersistenceService.saveLastViewedScreen(currentRoute);

      // If we're on a chat screen, save the conversation ID
      if (currentRoute.startsWith('/chat/')) {
        final conversationId = currentRoute.split('/chat/')[1];
        StatePersistenceService.saveLastViewedConversationId(conversationId);
      }
    }
  }

  /// Restore the last viewed screen
  Future<String?> getInitialRoute() async {
    await StatePersistenceService.initialize();
    return StatePersistenceService.getLastViewedScreen();
  }

  /// Get the last viewed conversation ID
  String? getLastViewedConversationId() {
    return StatePersistenceService.getLastViewedConversationId();
  }
}

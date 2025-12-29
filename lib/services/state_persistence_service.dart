import 'package:shared_preferences/shared_preferences.dart';

/// Service for persisting app state across sessions
class StatePersistenceService {
  static const String _lastViewedScreenKey = 'last_viewed_screen';
  static const String _conversationListScrollPositionKey =
      'conversation_list_scroll_position';
  static const String _lastViewedConversationIdKey =
      'last_viewed_conversation_id';

  static SharedPreferences? _prefs;

  /// Initialize the service
  static Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Save the last viewed screen
  static Future<void> saveLastViewedScreen(String screenName) async {
    await _prefs?.setString(_lastViewedScreenKey, screenName);
  }

  /// Get the last viewed screen
  static String? getLastViewedScreen() {
    return _prefs?.getString(_lastViewedScreenKey);
  }

  /// Save conversation list scroll position
  static Future<void> saveConversationListScrollPosition(
    double position,
  ) async {
    await _prefs?.setDouble(_conversationListScrollPositionKey, position);
  }

  /// Get conversation list scroll position
  static double getConversationListScrollPosition() {
    return _prefs?.getDouble(_conversationListScrollPositionKey) ?? 0.0;
  }

  /// Save the last viewed conversation ID
  static Future<void> saveLastViewedConversationId(
    String conversationId,
  ) async {
    await _prefs?.setString(_lastViewedConversationIdKey, conversationId);
  }

  /// Get the last viewed conversation ID
  static String? getLastViewedConversationId() {
    return _prefs?.getString(_lastViewedConversationIdKey);
  }

  /// Clear all saved state
  static Future<void> clearAll() async {
    await _prefs?.clear();
  }

  /// Check if service is initialized
  static bool get isInitialized => _prefs != null;
}

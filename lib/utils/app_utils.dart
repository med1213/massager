import 'package:flutter/services.dart';

/// Utility functions for the app
class AppUtils {
  /// Force hot restart (useful for development)
  static void hotRestart() {
    SystemNavigator.pop();
  }

  /// Check if app is in debug mode
  static bool get isDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }
}

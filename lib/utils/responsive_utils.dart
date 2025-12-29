import 'package:flutter/material.dart';

/// Utility class for responsive design calculations and breakpoints
class ResponsiveUtils {
  /// Screen size breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  /// Check if the current screen is mobile size
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  /// Check if the current screen is tablet size
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Check if the current screen is desktop size
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }

  /// Get responsive padding based on screen size
  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 16.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 24.0);
    } else {
      return const EdgeInsets.symmetric(horizontal: 32.0);
    }
  }

  /// Get responsive message bubble max width
  static double getMessageBubbleMaxWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (isMobile(context)) {
      return screenWidth * 0.8;
    } else if (isTablet(context)) {
      return screenWidth * 0.7;
    } else {
      // Desktop - use fixed max width for better readability
      return 600.0;
    }
  }

  /// Get responsive font size based on screen size
  static double getResponsiveFontSize(
    BuildContext context,
    double baseFontSize,
  ) {
    if (isMobile(context)) {
      return baseFontSize;
    } else if (isTablet(context)) {
      return baseFontSize * 1.1;
    } else {
      return baseFontSize * 1.2;
    }
  }

  /// Get responsive avatar size
  static double getAvatarSize(BuildContext context) {
    if (isMobile(context)) {
      return 24.0;
    } else if (isTablet(context)) {
      return 28.0;
    } else {
      return 32.0;
    }
  }

  /// Get responsive conversation tile height
  static double getConversationTileHeight(BuildContext context) {
    if (isMobile(context)) {
      return 72.0;
    } else if (isTablet(context)) {
      return 80.0;
    } else {
      return 88.0;
    }
  }

  /// Get responsive spacing between messages
  static double getMessageSpacing(BuildContext context) {
    if (isMobile(context)) {
      return 4.0;
    } else {
      return 6.0;
    }
  }

  /// Get responsive horizontal padding for message bubbles
  static EdgeInsets getMessageBubblePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0);
    } else {
      return const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0);
    }
  }

  /// Get responsive content padding for screens
  static EdgeInsets getScreenPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(0);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 32.0);
    } else {
      // Desktop - center content with max width
      final screenWidth = MediaQuery.of(context).size.width;
      final maxWidth = 800.0;
      final horizontalPadding = (screenWidth - maxWidth) / 2;
      return EdgeInsets.symmetric(
        horizontal: horizontalPadding > 0 ? horizontalPadding : 32.0,
      );
    }
  }

  /// Check if device is in landscape orientation
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Get keyboard height
  static double getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  /// Check if keyboard is visible
  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }
}

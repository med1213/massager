import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Messenger app theme configuration
class MessengerTheme {
  // Color constants based on Messenger design system
  static const Color primaryBlue = Color(0xFF00C6FF);
  static const Color lightBlue = Color(0xFFE3F2FD);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color secondaryBackground = Color(0xFFF5F5F5);
  static const Color textPrimary = Color(0xFF1C1E21);
  static const Color textSecondary = Color(0xFF65676B);
  static const Color borderColor = Color(0xFFE4E6EA);
  static const Color messageBubbleReceived = Color(0xFFF0F0F0);
  static const Color onlineIndicator = Color(0xFF42B883);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color warningColor = Color(0xFFF39C12);

  /// Main theme data for the Messenger app
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // Color scheme
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: primaryBlue,
            brightness: Brightness.light,
          ).copyWith(
            primary: primaryBlue,
            secondary: lightBlue,
            surface: backgroundWhite,
            surfaceContainerHighest: secondaryBackground,
            onSurface: textPrimary,
            onSurfaceVariant: textSecondary,
            outline: borderColor,
            error: errorColor,
          ),

      // Scaffold background
      scaffoldBackgroundColor: backgroundWhite,

      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 24),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryBlue,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),

      // Text theme with proper typography hierarchy
      textTheme: const TextTheme(
        // Message text
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textPrimary,
          height: 1.4,
        ),
        // Secondary text, last message preview
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: textPrimary,
          height: 1.3,
        ),
        // Small body text
        bodySmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: textSecondary,
          height: 1.2,
        ),
        // Conversation titles
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
          height: 1.2,
        ),
        // App bar titles
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          height: 1.2,
        ),
        // Timestamps and small labels
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: textSecondary,
          height: 1.1,
        ),
        // Medium labels
        labelMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textSecondary,
          height: 1.1,
        ),
        // Button text
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryBlue,
          height: 1.1,
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        filled: true,
        fillColor: backgroundWhite,
        hintStyle: const TextStyle(
          color: textSecondary,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBlue,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: textPrimary, iconSize: 24),
      ),

      // Card theme
      cardTheme: const CardThemeData(
        color: backgroundWhite,
        elevation: 1,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: borderColor,
        thickness: 0.5,
        space: 1,
      ),

      // List tile theme
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minVerticalPadding: 8,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        subtitleTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: textSecondary,
        ),
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryBlue,
        linearTrackColor: borderColor,
        circularTrackColor: borderColor,
      ),

      // Snack bar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: textPrimary,
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        actionTextColor: primaryBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),

      // Bottom sheet theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: backgroundWhite,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),

      // Dialog theme
      dialogTheme: const DialogThemeData(
        backgroundColor: backgroundWhite,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        contentTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textPrimary,
        ),
      ),
    );
  }

  /// Custom extensions for Messenger-specific styling
  static const double messageBubbleRadius = 18.0;
  static const double inputBorderRadius = 20.0;
  static const double cardBorderRadius = 12.0;
  static const double buttonBorderRadius = 8.0;

  /// Spacing constants
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 12.0;
  static const double spacingL = 16.0;
  static const double spacingXL = 20.0;
  static const double spacingXXL = 24.0;

  /// Message bubble specific styling
  static BoxDecoration sentMessageDecoration = const BoxDecoration(
    color: primaryBlue,
    borderRadius: BorderRadius.all(Radius.circular(messageBubbleRadius)),
  );

  static BoxDecoration receivedMessageDecoration = const BoxDecoration(
    color: messageBubbleReceived,
    borderRadius: BorderRadius.all(Radius.circular(messageBubbleRadius)),
  );

  /// Avatar styling
  static const double avatarSizeSmall = 20.0;
  static const double avatarSizeMedium = 24.0;
  static const double avatarSizeLarge = 32.0;

  /// Status bar styling helper
  static SystemUiOverlayStyle get statusBarStyle {
    return const SystemUiOverlayStyle(
      statusBarColor: primaryBlue,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: backgroundWhite,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }
}

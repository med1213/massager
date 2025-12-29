import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

/// A wrapper widget that provides responsive behavior and handles orientation changes
class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final bool centerContent;

  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.padding,
    this.centerContent = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenPadding = padding ?? ResponsiveUtils.getScreenPadding(context);
    final isLandscape = ResponsiveUtils.isLandscape(context);
    final isDesktop = ResponsiveUtils.isDesktop(context);

    Widget content = child;

    // Add responsive padding
    if (screenPadding != EdgeInsets.zero) {
      content = Padding(padding: screenPadding, child: content);
    }

    // Center content on desktop if requested
    if (centerContent && isDesktop) {
      content = Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: content,
        ),
      );
    }

    // Handle orientation changes
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            // Adjust layout based on available space
            if (isLandscape && ResponsiveUtils.isMobile(context)) {
              // In landscape mode on mobile, reduce vertical padding
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenPadding.horizontal,
                  vertical: screenPadding.vertical * 0.5,
                ),
                child: child,
              );
            }

            return content;
          },
        );
      },
    );
  }
}

/// A responsive scaffold that automatically handles responsive behavior
class ResponsiveScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool centerContent;
  final bool resizeToAvoidBottomInset;

  const ResponsiveScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.centerContent = false,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: ResponsiveWrapper(centerContent: centerContent, child: body),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}

/// A responsive container that adapts its size based on screen dimensions
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? mobileWidth;
  final double? tabletWidth;
  final double? desktopWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Decoration? decoration;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,
    this.padding,
    this.margin,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    double? width;

    if (ResponsiveUtils.isMobile(context)) {
      width = mobileWidth;
    } else if (ResponsiveUtils.isTablet(context)) {
      width = tabletWidth;
    } else {
      width = desktopWidth;
    }

    return Container(
      width: width,
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: child,
    );
  }
}

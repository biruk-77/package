import 'package:flutter/material.dart';

/// Represents an item in the navigation bar.
///
/// Supports both traditional icons/labels and custom widgets for maximum flexibility.
///
/// Example (traditional):
/// ```dart
/// NavBarItem(icon: Icons.home, label: 'Home')
/// ```
///
/// Example (custom widgets):
/// ```dart
/// NavBarItem(
///   customIcon: Image.asset('assets/custom_icon.png'),
///   customLabel: Text('Home', style: customStyle),
/// )
/// ```
class NavBarItem {
  /// Traditional icon data (optional if customIcon is provided)
  final IconData? icon;

  /// Custom icon widget (takes priority over icon)
  final Widget? customIcon;

  /// Traditional text label (optional if customLabel is provided)
  final String? label;

  /// Custom label widget (takes priority over label)
  final Widget? customLabel;

  /// Whether to show notification badge
  final bool hasNotification;

  /// Notification count for badges with count
  final int notificationCount;

  NavBarItem({
    this.icon,
    this.customIcon,
    this.label,
    this.customLabel,
    this.hasNotification = false,
    this.notificationCount = 0,
  }) : assert(
         icon != null || customIcon != null,
         'Either icon or customIcon must be provided',
       );

  /// Returns true if using custom icon widget
  bool get hasCustomIcon => customIcon != null;

  /// Returns true if using custom label widget
  bool get hasCustomLabel => customLabel != null;
}

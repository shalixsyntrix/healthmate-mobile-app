import 'package:flutter/material.dart';

/// Application color scheme following Material Design guidelines
/// with health-themed colors for different metrics
class AppColors {
  // Primary Colors
  static const primary = Color(0xFF00897B); // Teal - Health/Medical theme
  static const primaryDark = Color(0xFF00695C);
  static const primaryLight = Color(0xFF4DB6AC);

  // Metric-specific colors
  static const waterBlue = Color(0xFF2196F3); // Water intake
  static const caloriesOrange = Color(0xFFFF5722); // Calories burned
  static const stepsGreen = Color(0xFF4CAF50); // Steps walked

  // UI Colors
  static const background = Color(0xFFF5F5F5);
  static const cardBackground = Colors.white;
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
  static const divider = Color(0xFFBDBDBD);

  // Status Colors
  static const success = Color(0xFF4CAF50);
  static const error = Color(0xFFF44336);
  static const warning = Color(0xFFFFC107);
  static const info = Color(0xFF2196F3);
}

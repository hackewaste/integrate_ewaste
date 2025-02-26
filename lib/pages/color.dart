import 'package:flutter/material.dart';

class AppColors {
  // Base Colors
  static const Color background = Color(0xFFFAF7F2);    // Soft cream background
  static const Color primary = Color(0xFF94B49F);       // Muted sage green
  static const Color secondary = Color(0xFFB4A6AB);     // Dusty mauve
  static const Color accent = Color(0xFFFFB5A7);        // Coral peach
  static const Color text = Color(0xFF4A4A4A);          // Soft charcoal

  // Background Variations
  static const Color backgroundLight = Color(0xFFFFFBF5);
  static const Color backgroundDark = Color(0xFFF5F2ED);
  static const Color surfaceColor = Color(0xFFFFFFFF);

  // Primary Variations
  static const Color primaryLight = Color(0xFFAEC5B5);
  static const Color primaryDark = Color(0xFF7A9B86);
  static const Color primaryContainer = Color(0xFFE8F0EA);

  // Accent Variations
  static const Color accentLight = Color(0xFFFFCAC2);
  static const Color accentDark = Color(0xFFFF9B8B);
  static const Color accentContainer = Color(0xFFFFF0ED);

  // Text Variations
  static const Color textLight = Color(0xFF6B6B6B);
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color textMuted = Color(0xFF9E9E9E);
  static const Color textAlt = Color(0xFF3A3A3A); // ✅ Added missing textAlt

  // Status Colors
  static const Color success = Color(0xFF9BC4BC);
  static const Color warning = Color(0xFFE6B89C);
  static const Color error = Color(0xFFE4A5A5);
  static const Color info = Color(0xFFA5BBE4);

  // AppBar Color ✅ Added
  static const Color appBarColor = Color(0xFF37474F); // Dark Blue-Grey

  // Navigation Bar Colors ✅ Added
  static const Color selectedNavColor = Color(0xFF4CAF50); // Green
  static const Color unselectedNavColor = Color(0xFF9E9E9E); // Gray

  // Status Bar Color
  static const Color statusBarColor = Color(0xFF0A0A0A); // Dark Gray or Black

  // Gradient Colors
  static const List<Color> primaryGradient = [Color(0xFF94B49F), Color(0xFFAEC5B5)];
  static const List<Color> accentGradient = [Color(0xFFFFB5A7), Color(0xFFFFCAC2)];

  // ✅ Fix: Define missing colors
  static const Color bg200 = Color(0xFFF5F5F5); // Light Gray background
  static const Color bg300 = Color(0xFFE0E0E0); // Slightly darker gray background
  static const Color primary200 = Color(0xFF90CAF9); // Light blue (adjust as needed)
  static const Color text200 = Color(0xFF757575); // Medium gray text
}

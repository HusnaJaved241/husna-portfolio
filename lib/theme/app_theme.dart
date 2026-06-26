import 'package:flutter/material.dart';

/// Bold & Modern theme — deep indigo/violet gradient base with a warm
/// coral/amber accent. Designed to feel confident and current, not
/// like a generic template.
class AppColors {
  static const Color background = Color(0xFF0B0D17);
  static const Color surface = Color(0xFF151826);
  static const Color surfaceLight = Color(0xFF1E2235);
  static const Color primary = Color(0xFF6C5CE7); // violet
  static const Color primaryDark = Color(0xFF4834D4);
  static const Color accent = Color(0xFFFF7F50); // coral
  static const Color accentSecondary = Color(0xFFFFC857); // amber
  static const Color textPrimary = Color(0xFFF5F6FA);
  static const Color textSecondary = Color(0xFFA0A3B1);
  static const Color cardBorder = Color(0xFF2A2E45);

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4834D4), Color(0xFF6C5CE7), Color(0xFFFF7F50)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E2235), Color(0xFF151826)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF7F50), Color(0xFFFFC857)],
  );
}

class AppTextStyles {
  static const String fontFamily = 'Poppins';

  static TextStyle heroTitle = const TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.1,
    letterSpacing: -1,
  );

  static TextStyle sectionTitle = const TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle cardTitle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle body = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle tag = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
    letterSpacing: 0.5,
  );
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: AppTextStyles.fontFamily,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.surface,
    ),
  );
}

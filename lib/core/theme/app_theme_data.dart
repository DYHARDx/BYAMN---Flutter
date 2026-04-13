import 'package:flutter/material.dart';

class AppThemeData {
  static const Color _teal = Color(0xFF0D9488);
  static const Color _bgLight = Color(0xFFF3FBFA);
  static const Color _bgDark = Color(0xFF0E0E10);

  static ThemeData appLightThemeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _bgLight,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _teal,
      brightness: Brightness.light,
      primary: _teal,
      secondary: const Color(0xFF14B8A6),
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      elevation: 1.5,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFD7ECEA)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFD7ECEA)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _teal, width: 1.5),
      ),
    ),
  );

  static ThemeData appDarkThemeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _bgDark,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF9CA3AF),
      secondary: Color(0xFF6B7280),
      surface: Color(0xFF1A1A1D),
      onSurface: Color(0xFFE5E7EB),
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      backgroundColor: Color(0xFF151518),
    ),
    cardTheme: CardThemeData(
      elevation: 1,
      color: const Color(0xFF1A1A1D),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1F1F23),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF34343A)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF34343A)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF9CA3AF), width: 1.2),
      ),
    ),
  );
}

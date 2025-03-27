import 'package:flutter/material.dart';

/// AppTheme provides light and dark mode themes for the app.
class AppTheme {
  /// Light theme for bright mode.
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  /// Dark theme for dark mode.
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}

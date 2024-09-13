// lib/theme.dart
import 'package:flutter/material.dart';

// Enum for theme modes
enum AppTheme {
  light,
  dark,
}

class Themes {
  AppTheme? appTheme = AppTheme.light;

  Themes({required this.appTheme});

  void switchTheme() {
    if (appTheme! == AppTheme.light) {
      appTheme = AppTheme.dark;
    } else {
      appTheme = AppTheme.light;
    }
  }

  ThemeData getTheme() {
    if (appTheme! == AppTheme.light) {
      return lightTheme;
    }
    return darkTheme;
  }

  ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.green,
      primaryColor: Colors.green,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      textTheme: const TextTheme(
          headlineLarge: TextStyle(
              color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.black87, fontSize: 14)),
      buttonTheme: const ButtonThemeData(
          buttonColor: Colors.green, textTheme: ButtonTextTheme.primary),
      inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          labelStyle: TextStyle(color: Colors.green)),
      iconTheme: const IconThemeData(color: Colors.grey, size: 24),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.green,
        actionTextColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.green, fontSize: 18),
      ));
  ThemeData darkTheme = ThemeData(
    //brightness: Brightness.dark,

    // Primary and Accent Colors
    primaryColor: Colors.purple,

    // Background Colors
    scaffoldBackgroundColor: Colors.grey[400],

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.purple,
      elevation: 0, // Optional: set elevation for a flat look
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Text Theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
      headlineLarge: TextStyle(
          color: Colors.purpleAccent,
          fontSize: 24,
          fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: Colors.white54, fontSize: 16),
    ),

    // Button Theme
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.deepPurple[600],
      textTheme: ButtonTextTheme.primary,
    ),

    // Input Decoration Theme
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purpleAccent),
      ),
      labelStyle: TextStyle(color: Colors.purpleAccent),
      hintStyle: TextStyle(color: Colors.white54),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: Colors.purpleAccent,
      size: 24,
    ),

    // SnackBar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.deepPurple[800],
      contentTextStyle: const TextStyle(color: Colors.white),
      actionTextColor: Colors.purpleAccent,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.deepPurple[900],
      selectedItemColor: Colors.purpleAccent,
      unselectedItemColor: Colors.white70,
    ),

    // Dialog Theme
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.black87,
      titleTextStyle: TextStyle(color: Colors.purpleAccent, fontSize: 18),
      contentTextStyle: TextStyle(color: Colors.white),
    ),
  );
}

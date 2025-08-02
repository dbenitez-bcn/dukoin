import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF6366F1),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFFF1F5F9),
  onSecondary: Color(0xFF0F172A),
  error: Color(0xFFEF4444),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFFFFFFFF), // card
  onSurface: Color(0xFF252525), // card-foreground
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF8B5CF6),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF334155),
  onSecondary: Color(0xFFF8FAFC),
  error: Color(0xFFEF4444),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFF0F172A),
  onSurface: Color(0xFFF8FAFC),
);

final baseTextTheme = const TextTheme(
  displayLarge: TextStyle( // h1
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.5,
  ),
  displayMedium: TextStyle( // h2
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.5,
  ),
  displaySmall: TextStyle( // h3
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.5,
  ),
  headlineMedium: TextStyle( // h4
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  ),
  bodyLarge: TextStyle( // paragraph
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  ),
  labelLarge: TextStyle( // label
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  ),
  titleMedium: TextStyle( // input
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  ),
  labelMedium: TextStyle( // button
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  ),
);

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: lightColorScheme.surface,
  cardColor: lightColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.surface,
    foregroundColor: lightColorScheme.onSurface,
    elevation: 0,
  ),
  textTheme: baseTextTheme.apply(
    bodyColor: lightColorScheme.onSurface,
    displayColor: lightColorScheme.onSurface,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFF8FAFC), // input-background
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.1)), // border
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
);

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.surface,
  cardColor: darkColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.surface,
    foregroundColor: darkColorScheme.onSurface,
    elevation: 0,
  ),
  textTheme: baseTextTheme.apply(
    bodyColor: darkColorScheme.onSurface,
    displayColor: darkColorScheme.onSurface,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1E293B), // input-background
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF334155)), // border
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
);

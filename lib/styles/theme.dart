import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';

const appBorderRadius = 8.0;

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF6366F1),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFFF4F6F8),
  onSecondary: Color(0xFF0F172A),
  error: Color(0xFFEF4444),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF252525),
  outline: Color.fromRGBO(0, 0, 0, 0.1)
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
  outline: Color(0xFF334155),
);

final baseTextTheme = const TextTheme(
  displayLarge: TextStyle(
    // h1
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.5,
  ),
  displayMedium: TextStyle(
    // h2
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.5,
  ),
  displaySmall: TextStyle(
    // h3
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.5,
  ),
  headlineMedium: TextStyle(
    // h4
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  ),
  bodyLarge: TextStyle(
    // paragraph
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  ),
  bodyMedium: TextStyle(),
  labelLarge: TextStyle(
    // label
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  ),
  titleMedium: TextStyle(
    // input
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  ),
  labelMedium: TextStyle(
    // button
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
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: Border(bottom: BorderSide(color: DukoinColors.light.borderColor)),
  ),
  textTheme: baseTextTheme.apply(
    bodyColor: DukoinColors.light.bodyColor,
    displayColor: lightColorScheme.onSurface,
  ),
  cardTheme: CardThemeData(
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(appBorderRadius),
      side: BorderSide(color: DukoinColors.light.borderColor), // border
    ),
    margin: EdgeInsets.symmetric(vertical: 8),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: lightColorScheme.secondary,
    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
    hintStyle: TextStyle(color: Colors.grey[700]),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: DukoinColors.light.borderColor), // border
      borderRadius: const BorderRadius.all(Radius.circular(appBorderRadius)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(appBorderRadius)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0.0,
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(appBorderRadius)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(appBorderRadius)),
    ),
  ),
  extensions: <ThemeExtension<DukoinColors>>[DukoinColors.light],
);

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.surface,
  cardColor: darkColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.surface,
    foregroundColor: darkColorScheme.onSurface,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    // No shadow, so border is clean
    shape: Border(bottom: BorderSide(color: DukoinColors.dark.borderColor)),
  ),
  textTheme: baseTextTheme.apply(
    bodyColor: DukoinColors.dark.bodyColor,
    displayColor: darkColorScheme.onSurface,
  ),
  cardTheme: CardThemeData(
    color: Color(0xFF1e293b),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(appBorderRadius),
      side: BorderSide(color: DukoinColors.dark.borderColor), // border
    ),
    margin: EdgeInsets.symmetric(vertical: 8),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: darkColorScheme.secondary,
    // input-background
    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
    hintStyle: TextStyle(color: Colors.white54),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: DukoinColors.dark.borderColor), // border
      borderRadius: BorderRadius.all(Radius.circular(appBorderRadius)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF273140)), // border
      borderRadius: BorderRadius.all(Radius.circular(appBorderRadius)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0.0,
      backgroundColor: darkColorScheme.primary,
      foregroundColor: darkColorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(appBorderRadius)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(appBorderRadius)),
    ),
  ),
  extensions: <ThemeExtension<DukoinColors>>[DukoinColors.dark],
);

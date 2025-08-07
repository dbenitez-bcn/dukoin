import 'package:dukoin/presentation/state/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends InheritedNotifier<ThemeNotifier> {
  ThemeProvider({super.key, required super.child, required SharedPreferences prefs})
    : super(notifier: ThemeNotifier(prefs: prefs));

  static ThemeNotifier of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!.notifier!;
  }
}

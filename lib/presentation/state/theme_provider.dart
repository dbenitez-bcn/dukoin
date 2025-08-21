import 'package:dukoin/presentation/state/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends InheritedNotifier<ThemeNotifier> {
  ThemeProvider({super.key, required super.child})
    : super(notifier: ThemeNotifier(prefs: GetIt.I<SharedPreferences>()));

  static ThemeNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ThemeProvider>()!
        .notifier!;
  }
}

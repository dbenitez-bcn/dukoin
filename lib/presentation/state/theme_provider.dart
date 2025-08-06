import 'package:dukoin/presentation/state/theme_notifier.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends InheritedNotifier<ThemeNotifier> {
  ThemeProvider({super.key, required super.child})
    : super(notifier: ThemeNotifier());

  static ThemeNotifier of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ThemeProvider>();
    assert(provider != null, 'No ThemeProvider found in context');
    return provider!.notifier!;
  }
}

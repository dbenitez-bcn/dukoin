import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'currency_notifier.dart';

class CurrencyProvider extends InheritedNotifier<CurrencyNotifier> {
  CurrencyProvider({
    super.key,
    required super.child,
    required SharedPreferences prefs,
  }) : super(notifier: CurrencyNotifier(prefs: prefs));

  static CurrencyNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CurrencyProvider>()!
        .notifier!;
  }
}

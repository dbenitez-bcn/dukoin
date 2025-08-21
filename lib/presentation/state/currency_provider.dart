import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'currency_notifier.dart';

class CurrencyProvider extends InheritedNotifier<CurrencyNotifier> {
  CurrencyProvider({super.key, required super.child})
    : super(notifier: CurrencyNotifier(prefs: GetIt.I<SharedPreferences>()));

  static CurrencyNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CurrencyProvider>()!
        .notifier!;
  }
}

import 'package:dukoin/presentation/state/currency_provider.dart';
import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/presentation/state/navigation_state.dart';
import 'package:dukoin/presentation/state/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dukoin_main_screen.dart';

class DukoinApp extends StatelessWidget {
  final SharedPreferences prefs;

  const DukoinApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return ExpensesProvider(
      prefs: prefs,
      child: NavigationStateProvider(
        child: CurrencyProvider(
          prefs: prefs,
          child: ThemeProvider(prefs: prefs, child: DukoinMainScreen()),
        ),
      ),
    );
  }
}

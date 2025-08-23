import 'package:dukoin/presentation/state/currency_provider.dart';
import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/presentation/state/navigation_state.dart';
import 'package:dukoin/presentation/state/stats_page_state.dart';
import 'package:dukoin/presentation/state/theme_provider.dart';
import 'package:flutter/material.dart';

import 'dukoin_main_screen.dart';

class DukoinApp extends StatelessWidget {
  const DukoinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpensesProvider(
      child: NavigationStateProvider(
        child: StatsProvider(
          child: CurrencyProvider(
            child: ThemeProvider(child: DukoinMainScreen()),
          ),
        ),
      ),
    );
  }
}

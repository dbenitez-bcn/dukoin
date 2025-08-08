import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/pages/add_expense_page.dart';
import 'package:dukoin/presentation/pages/dukoin_page_route.dart';
import 'package:dukoin/presentation/pages/home_page.dart';
import 'package:dukoin/presentation/pages/settings_page.dart';
import 'package:dukoin/presentation/state/currency_provider.dart';
import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/presentation/state/navigation_state.dart';
import 'package:dukoin/presentation/state/theme_provider.dart';
import 'package:dukoin/presentation/widgets/bouncy_bottom_nav_bar.dart';
import 'package:dukoin/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return ExpensesProvider(
      child: NavigationStateProvider(
        child: CurrencyProvider(
          prefs: prefs,
          child: ThemeProvider(
            prefs: prefs,
            child: DukoinApp()
          ),
        ),
      ),
    );
  }
}

class DukoinApp extends StatelessWidget {
  const DukoinApp({super.key});

  static final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(), // Home
    GlobalKey<NavigatorState>(), // Settings
  ];

  static final List<Widget> _pages = [HomePage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dukoin',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeProvider.of(context).themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Stack(
          children: List.generate(
            _pages.length,
            (i) => DukoinPageRoute(
              navigatorKey: _navigatorKeys[i],
              index: i,
              child: _pages[i],
            ),
          ),
        ),
        bottomNavigationBar: BouncyBottomNavBar(),
      ),
    );
  }
}

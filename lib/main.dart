import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/pages/add_expense_page.dart';
import 'package:dukoin/presentation/pages/dukoin_page_route.dart';
import 'package:dukoin/presentation/pages/home_page.dart';
import 'package:dukoin/presentation/pages/settings_page.dart';
import 'package:dukoin/presentation/state/navigation_state.dart';
import 'package:dukoin/presentation/widgets/bouncy_bottom_nav_bar.dart';
import 'package:dukoin/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dukoin',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: NavigationState(child: DukoinApp()),
    );
  }
}

class DukoinApp extends StatelessWidget {
  DukoinApp({super.key});

  static final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(), // Home
    GlobalKey<NavigatorState>(), // Settings
  ];

  static final List<Widget> _pages = [HomePage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

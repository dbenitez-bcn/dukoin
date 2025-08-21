import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/pages/dukoin_page_route.dart';
import 'package:dukoin/presentation/pages/history_page.dart';
import 'package:dukoin/presentation/pages/home_page.dart';
import 'package:dukoin/presentation/pages/settings_page.dart';
import 'package:dukoin/presentation/pages/stats_page.dart';
import 'package:dukoin/presentation/state/theme_provider.dart';
import 'package:dukoin/presentation/widgets/bouncy_bottom_nav_bar.dart';
import 'package:dukoin/styles/theme.dart';
import 'package:flutter/material.dart';

class DukoinMainScreen extends StatelessWidget {
  const DukoinMainScreen({super.key});

  static final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(), // Home
    GlobalKey<NavigatorState>(), // History
    GlobalKey<NavigatorState>(), // Stats
    GlobalKey<NavigatorState>(), // Settings
  ];

  static final List<Widget> _pages = [
    HomePage(),
    HistoryPage(),
    StatsPage(),
    SettingsPage(),
  ];

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
              builder: (_) => _pages[i],
            ),
          ),
        ),
        bottomNavigationBar: BouncyBottomNavBar(),
      ),
    );
  }
}

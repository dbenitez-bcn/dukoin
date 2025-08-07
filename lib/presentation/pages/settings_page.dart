import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/theme_provider.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: FlutterLogo(size: 56.0),
                title: Text(AppLocalizations.of(context)!.settingsDarkThemeTitle, style: Theme.of(context).textTheme.labelLarge,),
                subtitle: Text(AppLocalizations.of(context)!.settingsDarkThemeSubtitle),
                trailing: Switch.adaptive(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: ThemeProvider.of(context).isDarkMode,
                  onChanged: ThemeProvider.of(context).toggleTheme,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/theme_provider.dart';
import 'package:dukoin/presentation/widgets/dukoin_icon.dart';
import 'package:flutter/material.dart';

class ThemeCardSwitch extends StatelessWidget {
  const ThemeCardSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: DukoinIcon(
          icon: isDarkMode
              ? Icons.dark_mode_outlined
              : Icons.light_mode_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          AppLocalizations.of(context)!.settingsDarkThemeTitle,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        subtitle: Text(
          AppLocalizations.of(context)!.settingsDarkThemeSubtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Switch.adaptive(
          activeColor: Theme.of(context).colorScheme.primary,
          value: isDarkMode,
          onChanged: ThemeProvider.of(context).toggleTheme,
        ),
      ),
    );
  }
}

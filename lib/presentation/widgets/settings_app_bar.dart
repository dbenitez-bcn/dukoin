import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/widgets/dukoin_icon.dart';
import 'package:flutter/material.dart';

class SettingsAppBar extends StatelessWidget {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return
      ListTile(
        contentPadding: const EdgeInsets.all(0.0),
        leading: DukoinIcon(
          icon: Icons.settings_outlined,
          color: Theme.of(context).colorScheme.primary,
          isSolid: true,
        ),
        title: Text(
          AppLocalizations.of(context)!.settingsTitle,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        subtitle: Text(AppLocalizations.of(context)!.settingsSubtitle),
      );
  }
}

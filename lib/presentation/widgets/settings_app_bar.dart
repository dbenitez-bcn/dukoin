import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/widgets/dukoin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsAppBar extends StatelessWidget {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DukoinAppBar(
      title: AppLocalizations.of(context)!.settingsTitle,
      subtitle: AppLocalizations.of(context)!.settingsSubtitle,
      icon: LucideIcons.settings,
    );
  }
}

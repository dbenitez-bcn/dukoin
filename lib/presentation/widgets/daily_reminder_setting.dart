import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/theme_provider.dart';
import 'package:dukoin/presentation/widgets/dukoin_icon.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';

class DailyReminderSetting extends StatelessWidget {
  DailyReminderSetting({super.key});

  bool isActive = true;

  void setActive(bool value) {
    isActive = value;
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).extension<DukoinColors>()!.relaxingTurquoise;
    return Card(
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          leading: DukoinIcon(
            icon: Icons.notifications_outlined,
            color: color,
          ),
          title: Text(
            AppLocalizations.of(context)!.settingsDailyReminderTitle,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          subtitle: Text(
            AppLocalizations.of(context)!.settingsDailyReminderSubtitle,
          ),
          trailing: Switch.adaptive(
            activeColor: color,
            value: isActive,
            onChanged: setActive,
          ),
        ),
      );
  }
}

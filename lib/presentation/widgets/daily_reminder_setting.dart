import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/theme_provider.dart';
import 'package:dukoin/presentation/widgets/dukoin_icon.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DailyReminderSetting extends StatelessWidget {
  const DailyReminderSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(
      context,
    ).extension<DukoinColors>()!.relaxingTurquoise;
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: DukoinIcon(icon: Icons.notifications_outlined, color: color),
        title: Text(
          AppLocalizations.of(context)!.settingsDailyReminderTitle,
          style: TextTheme.of(context).displaySmall,
        ),
        subtitle: Text(
          AppLocalizations.of(context)!.settingsDailyReminderSubtitle,
          style: TextTheme.of(context).bodyMedium,
        ),
        trailing: DailySwtich(),
      ),
    );
  }
}

class DailySwtich extends StatefulWidget {
  const DailySwtich({super.key});

  @override
  State<DailySwtich> createState() => _DailySwtichState();
}

class _DailySwtichState extends State<DailySwtich> {
  bool isActive = true;

  void setActive(bool value) {
    setState(() {
      isActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(
      context,
    ).extension<DukoinColors>()!.relaxingTurquoise;
    return Switch.adaptive(
      activeColor: color,
      value: isActive,
      onChanged: setActive,
    );
  }
}

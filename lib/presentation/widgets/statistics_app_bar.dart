import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/widgets/dukoin_app_bar.dart';
import 'package:dukoin/presentation/widgets/dukoin_dropdown_menu.dart';
import 'package:dukoin/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class StatisticsAppBar extends StatelessWidget {
  const StatisticsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> months = List.generate(
      12,
      (i) => DateFormat(
        'yMMMM',
        Localizations.localeOf(context).languageCode,
      ).format(DateTime(DateTime.now().year, i + 1)),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DukoinAppBar(
          title: AppLocalizations.of(context)!.statsPageTitle,
          subtitle: AppLocalizations.of(context)!.statsPageSubtitle,
          icon: LucideIcons.chartArea,
        ),
        Row(
          children: [
            Expanded(
              child: DukoinDropdownMenu(
                items: months,
                initialValue: months[0],
                onSelected: (value) {
                  print('Selected: $value');
                },
              ),
            ),
            SizedBox(width: 8),
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(LucideIcons.funnel, size: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

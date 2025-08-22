import 'package:dukoin/extensions/string_extension.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/widgets/dukoin_app_bar.dart';
import 'package:dukoin/presentation/widgets/dukoin_dropdown_menu.dart';
import 'package:dukoin/presentation/widgets/funnel_button.dart';
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
      ).format(DateTime(DateTime.now().year, i + 1)).capitalize(),
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
                initialValue: 0,
                onSelected: (value) {
                  print('Selected: $value');
                },
              ),
            ),
            SizedBox(width: 8),
            FunnelButton(),
          ],
        ),
      ],
    );
  }
}

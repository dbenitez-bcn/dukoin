import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/widgets/dukoin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class StatisticsAppBar extends StatelessWidget {
  const StatisticsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var greyColor = Colors.grey;
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
              child: Card.outlined(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(LucideIcons.calendar, size: 16, color: greyColor),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "Baby hello!",
                          style: TextTheme.of(context).titleSmall,
                        ),
                      ),
                      Icon(LucideIcons.chevronDown, size: 16, color: greyColor),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(LucideIcons.funnel, size: 16, color: greyColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

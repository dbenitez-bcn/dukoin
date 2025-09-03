import 'package:dukoin/domain/month_overview_vm.dart';
import 'package:dukoin/domain/state_status.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/stats_page_state.dart';
import 'package:dukoin/presentation/widgets/currency_text.dart';
import 'package:dukoin/presentation/widgets/dukoin_icon.dart';
import 'package:dukoin/presentation/widgets/dukoin_shimmer.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MonthOverview extends StatelessWidget {
  const MonthOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final statsBloc = StatsProvider.of(context);
    final shimmer = DukoinShimmer(height: 148, width: double.infinity);
    return FutureBuilder(
      future: statsBloc.loadMonthOverview(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return shimmer;
        }
        return StreamBuilder<StateStatus>(
          stream: statsBloc.statusStream.where(
            (value) => value == StateStatus.done,
          ),
          initialData: statsBloc.initialStatus,
          builder: (context, asyncSnapshot) {
            return MonthOverviewCard(vm: statsBloc.monthOverview);
          },
        );
      },
    );
  }
}

class MonthOverviewCard extends StatelessWidget {
  final MonthOverviewVM vm;

  const MonthOverviewCard({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DukoinIcon(
                  icon: LucideIcons.dollarSign,
                  color: Theme.of(context).colorScheme.primary,
                  isCircular: true,
                ),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.statsMonthOverViewTotal,
                      style: TextTheme.of(context).bodyMedium,
                    ),
                    CurrencyText.animated(
                      vm.totalAmount,
                      style: TextTheme.of(context).displayMedium,
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Text(
                  AppLocalizations.of(
                    context,
                  )!.homeTransactionsCounterTitle(vm.numOfTransactions),
                  style: TextTheme.of(context).bodyMedium,
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Flexible(
                  child: Transform.scale(
                    scale: 0.85,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        DukoinIcon(
                          icon: LucideIcons.calendar,
                          color: Theme.of(
                            context,
                          ).extension<DukoinColors>()!.relaxingTurquoise,
                          isCircular: true,
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.statsMonthOverViewDailyAvg,
                              style: TextTheme.of(context).bodyMedium,
                            ),
                            CurrencyText.animated(
                              vm.dailyAverage,
                              style: TextTheme.of(context).displayMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Transform.scale(
                    scale: 0.85,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        DukoinIcon(
                          icon: LucideIcons.calendarDays,
                          color: Theme.of(
                            context,
                          ).extension<DukoinColors>()!.emeraldGreen,
                          isCircular: true,
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.statsMonthOverViewWeeklyAvg,
                              style: TextTheme.of(context).bodyMedium,
                            ),
                            CurrencyText.animated(
                              vm.weeklyAverage,
                              style: TextTheme.of(context).displayMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

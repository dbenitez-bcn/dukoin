import 'package:dukoin/domain/state_status.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/stats_page_state.dart';
import 'package:dukoin/presentation/widgets/dukoin_shimmer.dart';
import 'package:dukoin/presentation/widgets/expense_info_card.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TopFiveOfTheMonth extends StatelessWidget {
  const TopFiveOfTheMonth({super.key});

  @override
  Widget build(BuildContext context) {
    final shimmer = DukoinShimmer(height: 100);
    final statsBloc = StatsProvider.of(context);
    return FutureBuilder(
      future: statsBloc.loadTopFive(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return shimmer;
        }
        return StreamBuilder<StateStatus>(
          stream: statsBloc.statusStream,
          initialData: statsBloc.initialStatus,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasData &&
                asyncSnapshot.data! == StateStatus.loading) {
              return shimmer;
            } else if (statsBloc.topFiveExpenses.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.trophy,
                        color: Theme.of(
                          context,
                        ).extension<DukoinColors>()!.goldenEra,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.statsTopFiveTitle(statsBloc.topFiveExpenses.length),
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
                ...statsBloc.topFiveExpenses.map(
                  (e) => ExpenseInfoCard(expense: e),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

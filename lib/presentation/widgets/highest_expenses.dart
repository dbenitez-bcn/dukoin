import 'package:dukoin/domain/state_status.dart';
import 'package:dukoin/domain/transaction.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/stats_page_state.dart';
import 'package:dukoin/presentation/widgets/currency_text.dart';
import 'package:dukoin/presentation/widgets/dukoin_shimmer.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HighestExpenses extends StatelessWidget {
  const HighestExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    final shimmer = DukoinShimmer(height: 100);
    final statsBloc = StatsProvider.of(context);
    return FutureBuilder(
      future: statsBloc.loadHighestExpenses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return shimmer;
        }
        return StreamBuilder<StateStatus>(
          stream: statsBloc.statusStream,
          initialData: statsBloc.initialStatus,
          builder: (context, asyncSnapshot) {
            if (statsBloc.topFiveExpenses.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
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
                TopExpensesListCard(expenses: statsBloc.topFiveExpenses),
              ],
            );
          },
        );
      },
    );
  }
}

class TopExpensesListCard extends StatelessWidget {
  final List<Expense> expenses;

  const TopExpensesListCard({super.key, required this.expenses});

  Widget _buildExpenseItem(BuildContext context, Expense expense, int index) {
    Color golden = Theme.of(context).extension<DukoinColors>()!.goldenEra;
    Widget numberCircle = CircleAvatar(
      backgroundColor: golden.withAlpha(64),
      child: Text(
        "#${index + 1}",
        style: TextStyle(color: golden, fontWeight: FontWeight.w600),
      ),
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              numberCircle,
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            expense.description,
                            style: TextTheme.of(context).displaySmall,
                            softWrap: true, // allows multiple lines
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${expense.category.localized(context)} ${expense.category.icon} · ${DateFormat('MMM d', AppLocalizations.of(context)!.localeName).format(expense.createdAt)}",
                      style: TextTheme.of(context).bodyMedium,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              CurrencyText(
                expense.amount,
                style: TextTheme.of(context).displaySmall,
              ),
            ],
          ),
        ),
        if (index < expenses.length - 1) Divider(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: List.generate(
            expenses.length,
            (i) => _buildExpenseItem(context, expenses[i], i),
          ),
        ),
      ),
    );
  }
}

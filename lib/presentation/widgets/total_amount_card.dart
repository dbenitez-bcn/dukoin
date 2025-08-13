import 'package:dukoin/domain/time_period.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/currency_provider.dart';
import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/presentation/state/expenses_bloc.dart';
import 'package:dukoin/utils/utils.dart';
import 'package:flutter/material.dart';

class TotalAmountCard extends StatelessWidget {
  const TotalAmountCard({super.key});

  String _getTimePeriodTitle(BuildContext context, TimePeriod period) {
    switch (period) {
      case TimePeriod.day:
        return AppLocalizations.of(context)!.homeTodayTotalTitle;
      case TimePeriod.week:
        return AppLocalizations.of(context)!.homeWeekTotalTitle;
      case TimePeriod.month:
        return AppLocalizations.of(context)!.homeMonthTotalTitle;
      case TimePeriod.all:
        return AppLocalizations.of(context)!.homeAllTotalTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    var expensesBloc = ExpensesProvider.of(context);
    return StreamBuilder<TotalAmountCardVM>(
      stream: expensesBloc.vmStream,
      initialData: expensesBloc.vm,
      builder: (context, asyncSnapshot) {
        return SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  Text(
                    _getTimePeriodTitle(
                      context,
                      expensesBloc.currentTimePeriod,
                    ),
                    style: TextTheme.of(context).bodyMedium,
                  ),
                  Text(
                    formatCurrency(
                      CurrencyProvider.of(context).currency,
                      asyncSnapshot.data!.amount,
                      AppLocalizations.of(context)!.localeName,
                    ),
                    style: TextTheme.of(context).displayLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.homeTransactionsCounterTitle(
                      asyncSnapshot.data!.totalTransactions,
                    ),
                    style: TextTheme.of(context).bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

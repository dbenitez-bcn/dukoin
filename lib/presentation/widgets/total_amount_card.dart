import 'package:dukoin/domain/time_period.dart';
import 'package:dukoin/domain/total_amount_vm.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/presentation/widgets/currency_text.dart';
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
    return StreamBuilder<TotalAmountVM>(
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
                  CurrencyText.animated(
                    asyncSnapshot.data!.amount,
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

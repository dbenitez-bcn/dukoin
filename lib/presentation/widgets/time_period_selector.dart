import 'package:dukoin/domain/time_period.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';

class TimePeriodSelector extends StatelessWidget {
  const TimePeriodSelector({super.key});

  String _getTimePeriodTitle(BuildContext context, TimePeriod period) {
    switch (period) {
      case TimePeriod.day:
        return AppLocalizations.of(context)!.homeTimePeriodDay;
      case TimePeriod.week:
        return AppLocalizations.of(context)!.homeTimePeriodWeek;
      case TimePeriod.month:
        return AppLocalizations.of(context)!.homeTimePeriodMonth;
      case TimePeriod.all:
        return AppLocalizations.of(context)!.homeTimePeriodAll;
    }
  }

  @override
  Widget build(BuildContext context) {
    var expensesBloc = ExpensesProvider.of(context);
    return StreamBuilder<TimePeriod>(
      stream: expensesBloc.timePeriodStream,
      initialData: expensesBloc.currentTimePeriod,
      builder: (context, asyncSnapshot) {
        return Card.outlined(
          margin: EdgeInsets.only(top: 12, bottom: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: Theme.of(context).extension<DukoinColors>()!.borderColor,
            ), // border
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(TimePeriod.values.length, (i) {
                var isSelected = TimePeriod.values[i] == asyncSnapshot.data!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 16.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                    ),
                    duration: Duration(milliseconds: 200),
                    child: InkWell(
                      child: Text(
                        _getTimePeriodTitle(context, TimePeriod.values[i]),
                        style: isSelected
                            ? TextTheme.of(context).labelLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )
                            : TextTheme.of(context).labelMedium,
                      ),
                      onTap: () async {
                        await expensesBloc.setTimePeriod(TimePeriod.values[i]);
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

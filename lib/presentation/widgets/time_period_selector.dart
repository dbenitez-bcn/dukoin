import 'package:dukoin/domain/time_period.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/styles/theme.dart';
import 'package:flutter/material.dart';

class OldTimePeriodSelector extends StatelessWidget {
  const OldTimePeriodSelector({super.key});

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
            borderRadius: BorderRadius.circular(appBorderRadius),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
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
                      borderRadius: BorderRadius.circular(appBorderRadius),
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
    final expensesBloc = ExpensesProvider.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: StreamBuilder<TimePeriod>(
        stream: expensesBloc.timePeriodStream,
        initialData: expensesBloc.currentTimePeriod,
        builder: (context, snapshot) {
          final selectedIndex = TimePeriod.values.indexOf(snapshot.data!);

          return Card(
            margin: const EdgeInsets.only(top: 12, bottom: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(appBorderRadius),
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final buttonWidth =
                      constraints.maxWidth / TimePeriod.values.length;

                  return Stack(
                    children: [
                      // Sliding background
                      AnimatedPositioned(
                        left: buttonWidth * selectedIndex,
                        top: 0,
                        bottom: 0,
                        width: buttonWidth,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(
                              appBorderRadius,
                            ),
                          ),
                        ),
                      ),
                      // Row of buttons
                      Row(
                        children: List.generate(TimePeriod.values.length, (i) {
                          final isSelected = i == selectedIndex;

                          return SizedBox(
                            width: buttonWidth,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  appBorderRadius,
                                ),
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  await expensesBloc.setTimePeriod(
                                    TimePeriod.values[i],
                                  );
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4.0,
                                      horizontal: 4.0,
                                    ),
                                    child: AnimatedDefaultTextStyle(
                                      style: isSelected
                                          ? TextTheme.of(
                                              context,
                                            ).labelLarge!.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            )
                                          : TextTheme.of(context).labelMedium!,
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      curve: Curves.fastOutSlowIn,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          _getTimePeriodTitle(
                                            context,
                                            TimePeriod.values[i],
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

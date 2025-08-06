import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/pages/add_expense_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SafeArea(
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.homeTitle,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                getFormattedCurrentDate(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AddExpensePage()));
        },
      ),
    );
  }

  String getFormattedCurrentDate() {
    final now = DateTime.now();
    final weekdayNames = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final weekday = weekdayNames[now.weekday - 1];
    final month = monthNames[now.month - 1];
    final day = now.day;
    final year = now.year;

    return '$weekday, $month $day, $year';
  }
}

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text('Daily Expenses', style: Theme.of(context).textTheme.displayLarge,),
              Text(getFormattedCurrentDate(), style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
        ),
      ),
    );
  }

  String getFormattedCurrentDate() {
    final now = DateTime.now();
    final weekdayNames = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    final monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    final weekday = weekdayNames[now.weekday - 1];
    final month = monthNames[now.month - 1];
    final day = now.day;
    final year = now.year;

    return '$weekday, $month $day, $year';
  }
}

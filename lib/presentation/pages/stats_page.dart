import 'package:dukoin/presentation/widgets/month_evolution.dart';
import 'package:dukoin/presentation/widgets/month_overview.dart';
import 'package:dukoin/presentation/widgets/statistics_app_bar.dart';
import 'package:dukoin/presentation/widgets/top_five_of_the_month.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  StatisticsAppBar(),
                  MonthOverview(),
                  MonthEvolution(),
                  TopFiveOfTheMonth(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

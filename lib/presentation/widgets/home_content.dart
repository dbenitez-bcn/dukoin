import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/presentation/widgets/dukoin_shimmer.dart';
import 'package:dukoin/presentation/widgets/last_expenses.dart';
import 'package:dukoin/presentation/widgets/time_period_selector.dart';
import 'package:dukoin/presentation/widgets/total_amount_card.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        TimePeriodSelector(),
        TotalAmountCard(),
        SizedBox(height: 16.0),
        LastExpenses(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ExpensesProvider.of(context).load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildContent(context);
        } else {
          return HomeContentLoading();
        }
      },
    );
  }
}

class HomeContentLoading extends StatelessWidget {
  const HomeContentLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: DukoinShimmer(height: 50),
        ),
        SizedBox(height: 8),
        DukoinShimmer(height: 124),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(flex: 3, child: DukoinShimmer()),
            Flexible(flex: 2, child: Container()),
            Flexible(flex: 1, child: DukoinShimmer()),
          ],
        ),
        SizedBox(height: 16),
        DukoinShimmer(height: 60),
        SizedBox(height: 16),
        DukoinShimmer(height: 60),
        SizedBox(height: 16),
        DukoinShimmer(height: 60),
        SizedBox(height: 16),
        DukoinShimmer(height: 60),
      ],
    );
  }
}

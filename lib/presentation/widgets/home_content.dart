import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/presentation/widgets/last_expenses.dart';
import 'package:dukoin/presentation/widgets/time_period_selector.dart';
import 'package:dukoin/presentation/widgets/total_amount_card.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  Widget _buildLoading(BuildContext context) {
    return CircularProgressIndicator();
  }

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
          return _buildLoading(context);
        }
      },
    );
  }
}

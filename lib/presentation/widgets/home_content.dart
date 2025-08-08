import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/presentation/widgets/total_amount_card.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  Widget _buildLoading(BuildContext context) {
    return CircularProgressIndicator();
  }

  Widget _buildContent(BuildContext context) {
    return Column(children: [TotalAmountCard()]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ExpensesProvider.of(context).loadExpenses(),
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

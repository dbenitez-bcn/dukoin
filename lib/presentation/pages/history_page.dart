import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/presentation/widgets/history_view.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpenseHistoryListView(
        expenses: ExpensesProvider.of(context).expenses,
      ),
    );
  }
}

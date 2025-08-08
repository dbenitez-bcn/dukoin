import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/presentation/widgets/expense_info_card.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Expense>>(
      stream: ExpensesProvider.of(context).expensesStream,
      initialData: [],
      builder: (context, snapshot) {
        List<Expense> expenses = snapshot.data ?? [];
        return Column(
          children: List<Widget>.generate(expenses.length, (index) {
            return ExpenseInfoCard(expense: expenses[index]);
          }),
        );
      },
    );
  }
}

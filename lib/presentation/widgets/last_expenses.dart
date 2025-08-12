import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/presentation/state/navigation_state.dart';
import 'package:dukoin/presentation/widgets/expense_info_card.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';

class LastExpenses extends StatelessWidget {
  const LastExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.homeLastExpensesTitle,
              style: TextTheme.of(context).displayMedium,
            ),
            InkWell(
              onTap: () {
                NavigationStateProvider.of(context).setPageIndex(1);
              },
              borderRadius: BorderRadius.circular(8),
              child: Row(
                children: [
                  SizedBox(width: 6.0),
                  Text(AppLocalizations.of(context)!.homeLastExpensesSeeAll),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Theme.of(
                      context,
                    ).extension<DukoinColors>()!.bodyColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        StreamBuilder<List<Expense>>(
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
        ),
      ],
    );
  }
}

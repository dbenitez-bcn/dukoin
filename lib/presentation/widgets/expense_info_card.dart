import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/widgets/currency_text.dart';
import 'package:dukoin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseInfoCard extends StatelessWidget {
  final Expense expense;

  const ExpenseInfoCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 16.0),
              child: Text(
                getIconFromCategory(expense.category),
                style: TextTheme.of(context).displayMedium,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          expense.description,
                          style: TextTheme.of(context).displaySmall,
                          softWrap: true, // allows multiple lines
                          maxLines: 2, // limit to 2 lines if needed
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      CurrencyText(amount: expense.amount),
                    ],
                  ),
                  Text(
                    "${getCategoryTitle(context, expense.category)} · ${DateFormat('MMM d', AppLocalizations.of(context)!.localeName).format(expense.createdAt)}",
                    style: TextTheme.of(context).bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

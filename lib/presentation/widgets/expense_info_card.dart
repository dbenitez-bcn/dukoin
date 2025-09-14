import 'package:dukoin/domain/transaction.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/widgets/currency_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionInfoCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionInfoCard({super.key, required this.transaction});

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
                buildCategoryIcon(),
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
                          transaction.description,
                          style: TextTheme.of(context).displaySmall,
                          softWrap: true, // allows multiple lines
                          maxLines: 2, // limit to 2 lines if needed
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      CurrencyText(
                        transaction is Expense
                            ? -1 * transaction.amount
                            : transaction.amount,
                      ),
                    ],
                  ),
                  Text(
                    "${buildCategoryTitle(context)} · ${DateFormat('MMM d', AppLocalizations.of(context)!.localeName).format(transaction.createdAt)}",
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

  String buildCategoryTitle(BuildContext context) {
    if (transaction is Expense) {
      return (transaction as Expense).category.localized(context);
    } else {
      return (transaction as Income).category.localized(context);
    }
  }

  String buildCategoryIcon() {
    if (transaction is Expense) {
      return (transaction as Expense).category.icon;
    } else {
      return (transaction as Income).category.icon;
    }
  }
}

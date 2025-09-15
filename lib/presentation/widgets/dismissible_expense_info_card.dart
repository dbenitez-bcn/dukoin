import 'package:dukoin/domain/category.dart';
import 'package:dukoin/domain/transaction.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/presentation/widgets/currency_text.dart';
import 'package:dukoin/presentation/widgets/dismissable_animation_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DismissibleExpenseInfoCard extends StatelessWidget {
  final Transaction transaction;

  const DismissibleExpenseInfoCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<DismissibleAnimatedItemState>();

    return DismissibleAnimatedItem(
      key: key,
      onRemove: () {
        ExpensesProvider.of(context).delete(transaction.id!);
      },
      child: Card.outlined(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                child: Text(
                  transaction.category.icon,
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
                          transaction.category is ExpenseCategory
                              ? -1 * transaction.amount
                              : transaction.amount,
                        ),
                      ],
                    ),
                    Text(
                      "${transaction.category.localized(context)} · ${DateFormat('MMM d', AppLocalizations.of(context)!.localeName).format(transaction.createdAt)}",
                      style: TextTheme.of(context).bodyMedium,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  key.currentState?.dismiss();
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

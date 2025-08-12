import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/currency_provider.dart';
import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/utils/utils.dart';
import 'package:flutter/material.dart';

class TotalAmountCard extends StatelessWidget {
  const TotalAmountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.homeWeeklyTotalTitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              StreamBuilder<double>(
                stream: ExpensesProvider.of(context).totalAmountStream,
                initialData: 0.0,
                builder: (context, snapshot) {
                  return Text(
                    formatCurrency(
                      CurrencyProvider.of(context).currency,
                      snapshot.data!,
                      AppLocalizations.of(context)!.localeName,
                    ),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

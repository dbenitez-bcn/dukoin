import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/currency_provider.dart';
import 'package:dukoin/utils/utils.dart';
import 'package:flutter/material.dart';

class CurrencyText extends StatelessWidget {
  final double amount;
  final TextStyle? style;

  const CurrencyText(this.amount, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      formatCurrency(
        CurrencyProvider.of(context).currency,
        amount,
        AppLocalizations.of(context)!.localeName,
      ),
      style:
          style ??
          TextTheme.of(context).displaySmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}

import 'package:dukoin/domain/currency.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/currency_notifier.dart';
import 'package:dukoin/presentation/state/currency_provider.dart';
import 'package:dukoin/presentation/widgets/currency_dropdown_menu_item.dart';
import 'package:dukoin/presentation/widgets/dukoin_icon.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';

class DefaultCurrencySelector extends StatelessWidget {
  Currency selectedCurrency = Currency.EUR;

  DefaultCurrencySelector({super.key});

  void setCurrency(Currency? currency) {
    if (currency != null) {
      selectedCurrency = currency;
    }
  }

  @override
  Widget build(BuildContext context) {
    CurrencyNotifier currencyNotifier = CurrencyProvider.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(bottom: 16.0),
              leading: DukoinIcon(
                icon: Icons.attach_money,
                color: Theme.of(
                  context,
                ).extension<DukoinColors>()!.emeraldGreen,
              ),
              title: Text(
                AppLocalizations.of(context)!.settingsDefaultCurrencyTitle,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              subtitle: Text(
                AppLocalizations.of(context)!.settingsDefaultCurrencySubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            DropdownButtonFormField<Currency>(
              value: currencyNotifier.currency,
              items: Currency.values
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: CurrencyDropdownMenuItem(currency: c),
                    ),
                  )
                  .toList(),
              onChanged: currencyNotifier.changeCurrency,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.addExpenseCategoryHint,
              ),
              validator: (value) => value == null
                  ? AppLocalizations.of(context)!.addExpenseCategoryHint
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

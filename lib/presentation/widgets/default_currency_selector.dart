import 'package:dukoin/domain/currency.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/currency_notifier.dart';
import 'package:dukoin/presentation/state/currency_provider.dart';
import 'package:dukoin/presentation/widgets/dukoin_dropdown_menu.dart';
import 'package:dukoin/presentation/widgets/dukoin_icon.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';

class DefaultCurrencySelector extends StatelessWidget {
  const DefaultCurrencySelector({super.key});

  String _getCurrencyText(BuildContext context, Currency currency) {
    switch (currency) {
      case Currency.usd:
        return "\$ ${AppLocalizations.of(context)!.currencyUSD} (${currency.name})";
      case Currency.eur:
        return "€ ${AppLocalizations.of(context)!.currencyEUR} (${currency.name})";
      case Currency.gbp:
        return "£ ${AppLocalizations.of(context)!.currencyGBP} (${currency.name})";
      case Currency.jpy:
        return "¥ ${AppLocalizations.of(context)!.currencyJPY} (${currency.name})";
      case Currency.cad:
        return "C\$ ${AppLocalizations.of(context)!.currencyCAD} (${currency.name})";
      case Currency.aud:
        return "A\$ ${AppLocalizations.of(context)!.currencyAUD} (${currency.name})";
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
              contentPadding: const EdgeInsets.all(0),
              leading: DukoinIcon(
                icon: Icons.attach_money,
                color: Theme.of(
                  context,
                ).extension<DukoinColors>()!.emeraldGreen,
              ),
              title: Text(
                AppLocalizations.of(context)!.settingsDefaultCurrencyTitle,
                style: TextTheme.of(context).displaySmall,
              ),
              subtitle: Text(
                AppLocalizations.of(context)!.settingsDefaultCurrencySubtitle,
                style: TextTheme.of(context).bodyMedium,
              ),
            ),
            DukoinDropdownMenu(
              items: Currency.values
                  .map((c) => _getCurrencyText(context, c))
                  .toList(),
              initialValue: Currency.values.indexOf(currencyNotifier.currency),
              onSelected: (index) {
                currencyNotifier.changeCurrency(Currency.values[index]);
              },
              padding: 8.0,
              decoration: DukoinDropdownMenuThemeData.filled(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

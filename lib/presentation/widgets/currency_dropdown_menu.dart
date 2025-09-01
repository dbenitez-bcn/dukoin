import 'package:dukoin/domain/currency.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/currency_notifier.dart';
import 'package:dukoin/presentation/state/currency_provider.dart';
import 'package:flutter/material.dart';

import 'dukoin_dropdown_menu.dart';

class CurrencyDropdownMenu extends StatelessWidget {
  const CurrencyDropdownMenu({super.key});
  String _getText(BuildContext context, Currency currency) {
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

    return DukoinDropdownMenu(
      items: Currency.values.map((e) => _getText(context, e)).toList(),
      initialValue: Currency.values.indexOf(currencyNotifier.currency),
      onSelected: (index) {
        currencyNotifier.changeCurrency(Currency.values[index]);
      },
    );
  }
}

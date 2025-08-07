import 'package:dukoin/domain/currency.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CurrencyDropdownMenuItem extends StatelessWidget {
  final Currency currency;

  const CurrencyDropdownMenuItem({super.key, required this.currency});

  String getText(BuildContext context) {
    switch (currency) {
      case Currency.USD:
        return "\$ ${AppLocalizations.of(context)!.currencyUSD} (${currency.name})";
      case Currency.EUR:
        return "€ ${AppLocalizations.of(context)!.currencyEUR} (${currency.name})";
      case Currency.GBP:
        return "£ ${AppLocalizations.of(context)!.currencyGBP} (${currency.name})";
      case Currency.JPY:
        return "¥ ${AppLocalizations.of(context)!.currencyJPY} (${currency.name})";
      case Currency.CAD:
        return "C\$ ${AppLocalizations.of(context)!.currencyCAD} (${currency.name})";
      case Currency.AUD:
        return "A\$ ${AppLocalizations.of(context)!.currencyAUD} (${currency.name})";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(getText(context)),
        ),
      ],
    );
  }
}

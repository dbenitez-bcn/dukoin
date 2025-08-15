import 'package:dukoin/domain/currency.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CurrencyDropdownMenuItem extends StatelessWidget {
  final Currency currency;

  const CurrencyDropdownMenuItem({super.key, required this.currency});

  String getText(BuildContext context) {
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

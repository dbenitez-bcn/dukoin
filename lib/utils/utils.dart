import 'package:dukoin/domain/currency.dart';
import 'package:intl/intl.dart';

String formatCurrency(Currency currency, double amount, String locale) {
  final format = NumberFormat.currency(
    locale: locale,
    symbol: getCurrencySymbol(currency),
    decimalDigits: 2,
  );

  return format.format(amount);
}

String getCurrencySymbol(Currency currency) {
  switch (currency) {
    case Currency.USD:
      return '\$';
    case Currency.EUR:
      return '€';
    case Currency.GBP:
      return '£';
    case Currency.JPY:
      return '¥';
    case Currency.CAD:
      return 'C\$';
    case Currency.AUD:
      return 'A\$';
  }
}

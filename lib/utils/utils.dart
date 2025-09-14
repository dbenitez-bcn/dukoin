import 'package:dukoin/domain/currency.dart';
import 'package:intl/intl.dart';

// TODO: Split in different files and add tests (Effort: M | Value: L)
class DateUtils {
  static DateTime firstDayOfCurrentWeek() {
    final now = DateTime.now();
    final weekday = now.weekday;
    return DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: weekday - 1));
  }

  static DateTime currentDayDate() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime firstDayOfCurrentMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }
}

class FormatUtils {
  static String formatPercentage(
    double value,
    String locale, {
    int minFractionDigits = 0,
    int maxFractionDigits = 2,
  }) {
    final formatter = NumberFormat.percentPattern(locale)
      ..minimumFractionDigits = minFractionDigits
      ..maximumFractionDigits = maxFractionDigits;

    return formatter.format(value);
  }

  static String formatCurrency(
    Currency currency,
    double amount,
    String locale,
  ) {
    final format = NumberFormat.currency(
      locale: locale,
      symbol: _getCurrencySymbol(currency),
      decimalDigits: 2,
    );

    return format.format(amount);
  }

  static String _getCurrencySymbol(Currency currency) {
    switch (currency) {
      case Currency.usd:
        return '\$';
      case Currency.eur:
        return '€';
      case Currency.gbp:
        return '£';
      case Currency.jpy:
        return '¥';
      case Currency.cad:
        return 'C\$';
      case Currency.aud:
        return 'A\$';
    }
  }
}

import 'package:dukoin/domain/currency.dart';
import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String formatCurrency(Currency currency, double amount, String locale) {
  final format = NumberFormat.currency(
    locale: locale,
    symbol: _getCurrencySymbol(currency),
    decimalDigits: 2,
  );

  return format.format(amount);
}

String _getCurrencySymbol(Currency currency) {
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

String getIconFromCategory(ExpenseCategory category) {
  switch (category) {
    case ExpenseCategory.food:
      return '🍽️';
    case ExpenseCategory.transport:
      return '🚗';
    case ExpenseCategory.shopping:
      return '🛍️';
    case ExpenseCategory.entertainment:
      return '🎬';
    case ExpenseCategory.bills:
      return '📄';
    case ExpenseCategory.health:
      return '🏥';
    case ExpenseCategory.education:
      return '📚';
    default:
      return '💰';
  }
}


String getCategoryTitle(BuildContext context, ExpenseCategory category) {
  switch (category) {
    case ExpenseCategory.food:
      return AppLocalizations.of(context)!.categoryFood;
    case ExpenseCategory.transport:
      return AppLocalizations.of(context)!.categoryTransport;
    case ExpenseCategory.shopping:
      return AppLocalizations.of(context)!.categoryShopping;
    case ExpenseCategory.entertainment:
      return AppLocalizations.of(context)!.categoryEntertainment;
    case ExpenseCategory.bills:
      return AppLocalizations.of(context)!.categoryBills;
    case ExpenseCategory.health:
      return AppLocalizations.of(context)!.categoryHealth;
    case ExpenseCategory.education:
      return AppLocalizations.of(context)!.categoryEducation;
    default:
      return AppLocalizations.of(context)!.categoryOthers;
  }
}

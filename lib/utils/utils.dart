import 'package:dukoin/domain/currency.dart';
import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

// TODO: Split in different files (Effort: L | Value: M)
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
      return '🍔️';
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
    case ExpenseCategory.others:
      return '💰';
    case ExpenseCategory.travel:
      return '✈️';
    case ExpenseCategory.investments:
      return '📈';
    case ExpenseCategory.insurance:
      return '🛡️';
    case ExpenseCategory.subscriptions:
      return '💳';
    case ExpenseCategory.pets:
      return '🐾';
    case ExpenseCategory.house:
      return '🏠';
    case ExpenseCategory.personalCare:
      return '💇';
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
    case ExpenseCategory.others:
      return AppLocalizations.of(context)!.categoryOthers;
    case ExpenseCategory.travel:
      return AppLocalizations.of(context)!.categoryTravel;
    case ExpenseCategory.investments:
      return AppLocalizations.of(context)!.categoryInvestments;
    case ExpenseCategory.insurance:
      return AppLocalizations.of(context)!.categoryInsurance;
    case ExpenseCategory.subscriptions:
      return AppLocalizations.of(context)!.categorySubscriptions;
    case ExpenseCategory.pets:
      return AppLocalizations.of(context)!.categoryPets;
    case ExpenseCategory.personalCare:
      return AppLocalizations.of(context)!.categoryPersonalCare;
    case ExpenseCategory.house:
      return AppLocalizations.of(context)!.categoryHouse;
  }
}

DateTime firstDayOfCurrentWeek() {
  final now = DateTime.now();
  final weekday = now.weekday;
  return DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(Duration(days: weekday - 1));
}

DateTime currentDayDate() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

DateTime firstDayOfCurrentMonth() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 1);
}


import 'package:dukoin/domain/currency.dart';
import 'package:dukoin/domain/transaction.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

// TODO: Split in different files and add tests (Effort: M | Value: L)

class CategoryUtils {
  static String getIconFromCategory(ExpenseCategory category) {
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
      case ExpenseCategory.house:
        return '🏠';
    }
  }

  static String getIconFromIncomeCategory(IncomeCategory category) {
    switch (category) {
      case IncomeCategory.salary:
        return '💼';
      case IncomeCategory.freelance:
        return '🖥️️';
      case IncomeCategory.investment:
        return '📈️';
      case IncomeCategory.gift:
        return '🎁️';
      case IncomeCategory.bonus:
        return '⭐️';
      case IncomeCategory.interest:
        return '🏛️️';
      case IncomeCategory.others:
        return '💰️';
    }
  }

  static String getCategoryTitle(
    BuildContext context,
    ExpenseCategory category,
  ) {
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
      case ExpenseCategory.house:
        return AppLocalizations.of(context)!.categoryHouse;
    }
  }

  static String getIncomeCategoryTitle(
    BuildContext context,
    IncomeCategory category,
  ) {
    switch (category) {
      case IncomeCategory.salary:
        return AppLocalizations.of(context)!.categorySalary;
      case IncomeCategory.freelance:
        return AppLocalizations.of(context)!.categoryFreelance;
      case IncomeCategory.investment:
        return AppLocalizations.of(context)!.categoryInvestment;
      case IncomeCategory.gift:
        return AppLocalizations.of(context)!.categoryGift;
      case IncomeCategory.bonus:
        return AppLocalizations.of(context)!.categoryBonus;
      case IncomeCategory.interest:
        return AppLocalizations.of(context)!.categoryInterest;
      case IncomeCategory.others:
        return AppLocalizations.of(context)!.categoryOthers;
    }
  }
}

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

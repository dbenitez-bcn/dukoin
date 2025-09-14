import 'package:dukoin/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

sealed class Category {
  String localized(BuildContext context);

  String get icon;
  String get cName;

  factory Category.fromString(String value, {bool isExpense = true}) {
    if (isExpense) {
      return ExpenseCategory.values.firstWhere(
        (e) => e.name == value,
        orElse: () => ExpenseCategory.others,
      );
    } else {
      return IncomeCategory.values.firstWhere(
        (e) => e.name == value,
        orElse: () => IncomeCategory.others,
      );
    }
  }
}

enum ExpenseCategory implements Category {
  food,
  transport,
  shopping,
  entertainment,
  health,
  bills,
  house,
  education,
  investments,
  travel,
  others;

  @override
  String localized(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case ExpenseCategory.food:
        return l10n.categoryFood;
      case ExpenseCategory.transport:
        return l10n.categoryTransport;
      case ExpenseCategory.shopping:
        return l10n.categoryShopping;
      case ExpenseCategory.entertainment:
        return l10n.categoryEntertainment;
      case ExpenseCategory.health:
        return l10n.categoryHealth;
      case ExpenseCategory.bills:
        return l10n.categoryBills;
      case ExpenseCategory.house:
        return l10n.categoryHouse;
      case ExpenseCategory.education:
        return l10n.categoryEducation;
      case ExpenseCategory.investments:
        return l10n.categoryInvestments;
      case ExpenseCategory.travel:
        return l10n.categoryTravel;
      case ExpenseCategory.others:
        return l10n.categoryOthers;
    }
  }

  @override
  String get icon {
    switch (this) {
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

  @override
  String get cName => name;
}

enum IncomeCategory implements Category {
  salary,
  freelance,
  investment,
  gift,
  bonus,
  interest,
  others;

  @override
  String localized(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case IncomeCategory.salary:
        return l10n.categorySalary;
      case IncomeCategory.freelance:
        return l10n.categoryFreelance;
      case IncomeCategory.investment:
        return l10n.categoryInvestment;
      case IncomeCategory.gift:
        return l10n.categoryGift;
      case IncomeCategory.bonus:
        return l10n.categoryBonus;
      case IncomeCategory.interest:
        return l10n.categoryInterest;
      case IncomeCategory.others:
        return l10n.categoryOthers;
    }
  }

  @override
  String get icon {
    switch (this) {
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

  @override
  String get cName => name;
}

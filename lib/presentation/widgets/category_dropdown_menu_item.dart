import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CategoryDropdownMenuItem extends StatelessWidget {
  final ExpenseCategory category;

  const CategoryDropdownMenuItem({super.key, required this.category});

  String getIcon() {
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

  String getTitle(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(getIcon()),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(getTitle(context)),
        ),
      ],
    );
  }
}

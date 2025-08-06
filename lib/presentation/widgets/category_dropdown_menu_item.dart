import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/extensions/string_extension.dart';
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(getIcon()),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(category.name.capitalize()),
        )
      ],
    );
  }
}

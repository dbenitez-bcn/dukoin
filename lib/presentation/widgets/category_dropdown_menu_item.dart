import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/utils/utils.dart';
import 'package:flutter/material.dart';

class CategoryDropdownMenuItem extends StatelessWidget {
  final ExpenseCategory category;

  const CategoryDropdownMenuItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(CategoryUtils.getIconFromCategory(category)),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(CategoryUtils.getCategoryTitle(context, category)),
        ),
      ],
    );
  }
}

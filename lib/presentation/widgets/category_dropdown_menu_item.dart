import 'package:dukoin/domain/category.dart';
import 'package:flutter/material.dart';

class CategoryDropdownMenuItem extends StatelessWidget {
  final ExpenseCategory category;

  const CategoryDropdownMenuItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(category.icon),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(category.localized(context)),
        ),
      ],
    );
  }
}

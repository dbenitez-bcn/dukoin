import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/stats_page_state.dart';
import 'package:dukoin/presentation/widgets/category_button.dart';
import 'package:dukoin/presentation/widgets/dukoin_plain_button.dart';
import 'package:flutter/material.dart';

import 'dukoin_outline_button.dart';

class CategoryFilterBottomSheet extends StatefulWidget {
  final VoidCallback onSubmit;
  final List<ExpenseCategory> selectedCategories;

  const CategoryFilterBottomSheet({
    super.key,
    required this.onSubmit,
    required this.selectedCategories,
  });

  @override
  State<CategoryFilterBottomSheet> createState() =>
      _CategoryFilterBottomSheetState();
}

class _CategoryFilterBottomSheetState extends State<CategoryFilterBottomSheet> {
  List<ExpenseCategory> _selectedCategories = [];

  @override
  void initState() {
    _selectedCategories = List.of(widget.selectedCategories);
    super.initState();
  }

  void selectAll() {
    setState(() {
      _selectedCategories = ExpenseCategory.values.toList();
    });
  }

  void clearAll() {
    setState(() {
      _selectedCategories.clear();
    });
  }

  Widget _buildCategoryButton(BuildContext context, int index) {
    final category = ExpenseCategory.values[index];
    return CategoryButton(
      category: category,
      isActive: _selectedCategories.contains(category),
      onChanged: (isActive) {
        if (isActive) {
          setState(() {
            _selectedCategories.add(category);
          });
        } else {
          setState(() {
            _selectedCategories.remove(category);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Icon(
                            Icons.close_rounded,
                            size: 20.0,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    AppLocalizations.of(context)!.categoryFilterTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    AppLocalizations.of(context)!.categoryFilterSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  //const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            DukoinOutlineButton(
                              onPressed: selectAll,
                              title: AppLocalizations.of(context)!.selectAll,
                            ),
                            const SizedBox(width: 8.0),
                            DukoinOutlineButton(
                              onPressed: clearAll,
                              title: AppLocalizations.of(context)!.clearAll,
                            ),
                          ],
                        ),
                        DukoinPlainButton(
                          title: AppLocalizations.of(context)!
                              .categoryFilterCounter(
                                _selectedCategories.length,
                                ExpenseCategory.values.length,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: ExpenseCategory.values.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 🔹 two per row
                  mainAxisSpacing: 12, // vertical spacing
                  crossAxisSpacing: 8, // horizontal spacing
                  childAspectRatio:
                      4.0, // 🔹 wider than tall (adjust as you like)
                ),
                itemBuilder: _buildCategoryButton,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 8.0,
                ),
                child: ElevatedButton(
                  child: Text(
                    AppLocalizations.of(context)!.categoryFilterButtonTitle,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    StatsProvider.of(
                      context,
                    ).onCategoriesUpdated(_selectedCategories);
                    widget.onSubmit();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

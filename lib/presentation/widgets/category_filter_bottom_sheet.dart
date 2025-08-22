import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/widgets/dukoin_plain_button.dart';
import 'package:flutter/material.dart';

import 'dukoin_outline_button.dart';

class CategoryFilterBottomSheet extends StatelessWidget {
  const CategoryFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
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
                            onPressed: () {},
                            title: AppLocalizations.of(context)!.selectAll,
                          ),
                          const SizedBox(width: 8.0),
                          DukoinOutlineButton(
                            onPressed: () {},
                            title: AppLocalizations.of(context)!.clearAll,
                          ),
                        ],
                      ),
                      DukoinPlainButton(
                        onPressed: () {},
                        title: AppLocalizations.of(context)!
                            .categoryFilterCounter(
                              0,
                              ExpenseCategory.values.length,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                children: ExpenseCategory.values.map((category) {
                  return Text(category.name);
                }).toList(),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  AppLocalizations.of(context)!.categoryFilterButtonTitle,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

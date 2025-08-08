import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/expense_provider.dart';
import 'package:dukoin/presentation/widgets/category_dropdown_menu_item.dart';
import 'package:dukoin/presentation/widgets/fade_in_slice_from_bottom_animation.dart';
import 'package:dukoin/presentation/widgets/form_card_item.dart';
import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  ExpenseCategory? selectedCategory;
  DateTime selectedDate = DateTime.now();

  void setCategory(ExpenseCategory? category) {
    selectedCategory = category;
  }

  void setDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void clear() {
    amountController.clear();
    descriptionController.clear();
    selectedCategory = null;
    selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate() || selectedCategory == null) return;

    final expense = Expense(
      amount: double.parse(amountController.text.replaceAll(",", ".")),
      category: selectedCategory!,
      description: descriptionController.text,
      createdAt: selectedDate,
    );

    ExpensesProvider.of(context).addExpense(expense);
    clear();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addExpenseTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FadeInSliceFromBottomAnimation(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.only(top: 16),
              children: [
                FormCardItem(
                  title: AppLocalizations.of(
                    context,
                  )!.addExpenseAmountTitle("€"),
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    controller: amountController,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      hintText: AppLocalizations.of(
                        context,
                      )!.addExpenseAmountHint(0),
                    ),
                  ),
                ),
                FormCardItem(
                  title: AppLocalizations.of(
                    context,
                  )!.addExpenseDescriptionTitle,
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(
                        context,
                      )!.addExpenseDescriptionHint,
                    ),
                  ),
                ),
                FormCardItem(
                  title: AppLocalizations.of(context)!.addExpenseCategoryTitle,
                  child: DropdownButtonFormField<ExpenseCategory>(
                    value: selectedCategory,
                    items: ExpenseCategory.values
                        .map(
                          (c) => DropdownMenuItem(
                            value: c,
                            child: CategoryDropdownMenuItem(category: c),
                          ),
                        )
                        .toList(),
                    onChanged: setCategory,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(
                        context,
                      )!.addExpenseCategoryHint,
                    ),
                    validator: (value) => value == null
                        ? AppLocalizations.of(context)!.addExpenseCategoryHint
                        : null,
                  ),
                ),
                FormCardItem(
                  title: AppLocalizations.of(context)!.addExpenseDateTitle,
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) setDate(picked);
                    },
                    child: Card.outlined(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: Theme.of(
                        context,
                      ).inputDecorationTheme.enabledBorder,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.addExpenseDateValue(selectedDate),
                            ),
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Theme.of(context).colorScheme.primary,
                              size: 18.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _submit(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.addExpenseSubmitButtonTitle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

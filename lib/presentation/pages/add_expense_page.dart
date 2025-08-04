import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/presentation/state/add_expense_page_state.dart';
import 'package:dukoin/presentation/widgets/form_card_item.dart';
import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final AddExpensePageState controller = AddExpensePageState();
  //final ExpenseRepository repo = GetIt.I<ExpenseRepository>();

  final _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() ||
        controller.selectedCategory == null)
      return;

    final expense = Expense(
      amount: int.parse(controller.amountController.text),
      category: controller.selectedCategory!,
      description: controller.descriptionController.text,
      createdAt: controller.selectedDate,
    );

    //await repo.insertExpense(expense);
    controller.clear();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormCardItem(
                title: 'Amount (€)',
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: controller.amountController,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: TextStyle(color: Colors.grey[700]),
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                  ),
                ),
              ),
              FormCardItem(
                title: 'Category',
                child: DropdownButtonFormField<Category>(
                  value: controller.selectedCategory,
                  items: Category.values
                      .map((c) => DropdownMenuItem(value: c, child: Text(c.name)))
                      .toList(),
                  onChanged: controller.setCategory,
                  decoration: InputDecoration(labelText: 'Select a category'),
                  validator: (value) =>
                  value == null ? 'Select a category' : null,
                ),
              ),
              FormCardItem(
                title: 'Description',
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  autofocus: true,
                  controller: controller.descriptionController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'What did you spend on?',
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date: ${controller.selectedDate.toLocal().toString().split(' ')[0]}",
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: controller.selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) controller.setDate(picked);
                    },
                    child: Text('Pick Date'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text('Save Expense')),
            ],
          ),
        ),
      ),
    );
  }
}

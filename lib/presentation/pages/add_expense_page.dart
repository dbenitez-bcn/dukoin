import 'package:dukoin/domain/expense.dart';
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
  Category? selectedCategory;
  DateTime selectedDate = DateTime.now();

  void setCategory(Category? category) {
    selectedCategory = category;
  }

  void setDate(DateTime date) {
    selectedDate = date;
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
  //final ExpenseRepository repo = GetIt.I<ExpenseRepository>();

  final _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() ||
        selectedCategory == null)
      return;

    final expense = Expense(
      amount: int.parse(amountController.text),
      category: selectedCategory!,
      description: descriptionController.text,
      createdAt: selectedDate,
    );

    //await repo.insertExpense(expense);
    clear();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.only(top: 16),
            children: [
              FormCardItem(
                title: 'Amount (€)',
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: amountController,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    hintText: '0.00',
                  ),
                ),
              ),
              FormCardItem(
                title: 'Category',
                child: DropdownButtonFormField<Category>(
                  value: selectedCategory,
                  items: Category.values
                      .map(
                        (c) => DropdownMenuItem(value: c, child: Text(c.name)),
                      )
                      .toList(),
                  onChanged: setCategory,
                  decoration: InputDecoration(
                    hintText: 'Select a category',
                  ),
                  validator: (value) =>
                      value == null ? 'Select a category' : null,
                ),
              ),
              FormCardItem(
                title: 'Description',
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'What did you spend on?',
                  ),
                ),
              ),
              FormCardItem(
                title: "Date",
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate.toLocal().toString().split(' ')[0],
                    ),
                    TextButton(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setDate(picked);
                      },
                      child: Text('Pick Date'),
                    ),
                  ],
                ),
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

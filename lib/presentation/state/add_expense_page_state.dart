import 'package:dukoin/domain/expense.dart';
import 'package:flutter/material.dart';

class AddExpensePageState extends ChangeNotifier {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Category? selectedCategory;
  DateTime selectedDate = DateTime.now();

  void setCategory(Category? category) {
    selectedCategory = category;
    notifyListeners();
  }

  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void clear() {
    amountController.clear();
    descriptionController.clear();
    selectedCategory = null;
    selectedDate = DateTime.now();
    notifyListeners();
  }

  void disposeAll() {
    amountController.dispose();
    descriptionController.dispose();
  }
}

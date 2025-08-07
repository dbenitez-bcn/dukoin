import 'dart:async';

import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';

class ExpensesBloc {
  final ExpenseRepository _repo;

  List<Expense> _expenses = [];

  ExpensesBloc(this._repo);

  int get total => _expenses.length;

  Future<void> loadExpenses() async {
    _expenses = await _repo.getAll();
    //_studentsController.sink.add(_students);
  }

  Future<void> addExpense(Expense expense) async {
    await _repo.insert(expense);
    _expenses.add(expense);
  }
}

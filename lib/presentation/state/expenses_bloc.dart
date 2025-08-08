import 'dart:async';

import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';

class ExpensesBloc {
  final ExpenseRepository _repo;
  final _totalAmountController = StreamController<double>();

  List<Expense> _expenses = [];

  ExpensesBloc(this._repo);

  int get total => _expenses.length;

  Stream<double> get totalAmountStream => _totalAmountController.stream;

  Future<void> loadExpenses() async {
    _expenses = await _repo.getAll();
    _calculateTotal();
  }

  void _calculateTotal() {
    _totalAmountController.sink.add(
      _expenses.fold(0.0, (total, e) => total + e.amount),
    );
  }

  Future<void> addExpense(Expense expense) async {
    int id = await _repo.insert(expense);
    expense.id = id;
    _expenses.add(expense);
    _calculateTotal();
  }
}

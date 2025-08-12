import 'dart:async';

import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/utils/utils.dart';

class ExpensesBloc {
  final ExpenseRepository _repo;
  final _totalAmountController = StreamController<double>();
  final _expensesController = StreamController<List<Expense>>();

  List<Expense> _expenses = [];

  ExpensesBloc(this._repo);

  int get total => _expenses.length;

  Stream<double> get totalAmountStream => _totalAmountController.stream;

  Stream<List<Expense>> get expensesStream => _expensesController.stream;

  Future<void> loadExpenses() async {
    _expenses = await _repo.getAll();
    _updateStreams();
  }

  double _calculateTotalOfCurrentWeek() {
    int i = 0;
    double total = 0.0;
    while (i < _expenses.length &&
        _expenses[i].createdAt.compareTo(firstDayOfCurrentWeek()) >= 0) {
      total += _expenses[i++].amount;
    }
    return total;
  }

  void _updateStreams() {
    _totalAmountController.sink.add(_calculateTotalOfCurrentWeek());
    _expensesController.sink.add(
      _expenses.length <= 4 ? List.from(_expenses) : _expenses.sublist(0, 4),
    );
  }

  Future<void> addExpense(Expense expense) async {
    int id = await _repo.insert(expense);
    expense.id = id;
    _expenses.add(expense);
    _expenses.sort();
    _updateStreams();
  }

  Future<void> clearAllData() async {
    _expenses.clear();
    await _repo.deleteAll();
    _updateStreams();
  }

  Future<void> delete(int id) async {
    _expenses.removeWhere((e) => e.id == id);
    await _repo.delete(id);
    _updateStreams();
  }
}

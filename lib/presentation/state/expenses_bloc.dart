import 'dart:async';

import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';

class ExpensesBloc {
  final ExpenseRepository _repo;

  List<Expense> _expenses = [];

  ExpensesBloc(this._repo);

  int get total => _expenses.length;

  Future<void> loadStudents() async {
    _expenses = await _repo.getAll();
    print("Total expenses ${total}");
    //_studentsController.sink.add(_students);
  }
}

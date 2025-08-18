import 'dart:async';

import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/domain/time_period.dart';
import 'package:dukoin/domain/total_amount_vm.dart';
import 'package:dukoin/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesBloc {
  static final String _key = 'time_period';
  final ExpenseRepository _repo;
  final SharedPreferences _prefs;

  final _vmController = StreamController<TotalAmountVM>();

  Stream<TotalAmountVM> get vmStream => _vmController.stream;

  TotalAmountVM get vm => _vm;
  TotalAmountVM _vm = TotalAmountVM(0.0, 0);

  final _totalAmountController = StreamController<double>();
  final _lastExpensesController = StreamController<List<Expense>>();
  final _timePeriodController = StreamController<TimePeriod>();
  final TimePeriod initialTimePeriod = TimePeriod.week;

  List<Expense> _expenses = [];
  TimePeriod _currentTimePeriod = TimePeriod.week;

  ExpensesBloc(this._repo, this._prefs);

  TimePeriod get currentTimePeriod => _currentTimePeriod;

  List<Expense> get lastExpenses => _expenses;

  Stream<double> get totalAmountStream => _totalAmountController.stream;

  Stream<List<Expense>> get lastExpensesStream =>
      _lastExpensesController.stream;

  Stream<TimePeriod> get timePeriodStream => _timePeriodController.stream;

  Future<void> load() async {
    _expenses = await _repo.getLast();
    _currentTimePeriod = TimePeriod.values[_prefs.getInt(_key) ?? 1];
    _timePeriodController.add(_currentTimePeriod);
    await _updateVM();
    _updateStreams();
    await Future.delayed(Duration(seconds: 2));
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

  Future<void> _updateVM() async {
    switch (_currentTimePeriod) {
      case TimePeriod.day:
        _vm = await _repo.getTotalAmount(date: currentDayDate());
      case TimePeriod.week:
        _vm = await _repo.getTotalAmount(date: firstDayOfCurrentWeek());
      case TimePeriod.month:
        _vm = await _repo.getTotalAmount(date: firstDayOfCurrentMonth());
      case TimePeriod.all:
        _vm = await _repo.getTotalAmount(date: DateTime(0));
    }
    _vmController.add(_vm);
  }

  Future<void> _updateStreams() async {
    _totalAmountController.add(_calculateTotalOfCurrentWeek());
    _lastExpensesController.add(_expenses);
    await _updateVM();
  }

  Future<void> addExpense(Expense expense) async {
    int id = await _repo.insert(expense);
    expense.id = id;
    _expenses.add(expense);
    _expenses.sort();
    await _updateStreams();
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

  Future<void> setTimePeriod(TimePeriod newValue) async {
    await _prefs.setInt(_key, newValue.index);
    _currentTimePeriod = newValue;
    _timePeriodController.add(newValue);
    await _updateVM();
  }
}

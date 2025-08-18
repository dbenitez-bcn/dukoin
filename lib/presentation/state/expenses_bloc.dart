import 'dart:async';

import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/domain/state_status.dart';
import 'package:dukoin/domain/time_period.dart';
import 'package:dukoin/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TotalAmountCardVM {
  final double amount;
  final int totalTransactions;

  TotalAmountCardVM(this.amount, this.totalTransactions);
}

class ExpensesBloc {
  static final String _key = 'time_period';
  final ExpenseRepository _repo;
  final SharedPreferences _prefs;

  final _vmController = StreamController<TotalAmountCardVM>();

  Stream<TotalAmountCardVM> get vmStream => _vmController.stream;

  TotalAmountCardVM get vm => _vm;
  TotalAmountCardVM _vm = TotalAmountCardVM(0.0, 0);

  final _totalAmountController = StreamController<double>();
  final _expensesController = StreamController<List<Expense>>();
  final _timePeriodController = StreamController<TimePeriod>();
  final _statusController = StreamController<StateStatus>();
  final TimePeriod initialTimePeriod = TimePeriod.week;

  List<Expense> _expenses = [];
  TimePeriod _currentTimePeriod = TimePeriod.week;

  ExpensesBloc(this._repo, this._prefs);

  TimePeriod get currentTimePeriod => _currentTimePeriod;
  List<Expense> get expenses => _expenses;
  List<Expense> get lastExpenses => _expenses.length > 4 ? _expenses.sublist(0, 4) : _expenses;

  Stream<double> get totalAmountStream => _totalAmountController.stream;

  Stream<List<Expense>> get expensesStream => _expensesController.stream;

  Stream<TimePeriod> get timePeriodStream => _timePeriodController.stream;

  Stream<StateStatus> get statusStream => _statusController.stream;

  Future<void> load() async {
    _expenses = await _repo.getLast();
    _currentTimePeriod = TimePeriod.values[_prefs.getInt(_key) ?? 1];
    _timePeriodController.add(_currentTimePeriod);
    _updateVM();
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

  void _updateVM() {
    switch (_currentTimePeriod) {
      case TimePeriod.day:
        _calculateVMFromDate(currentDayDate());
      case TimePeriod.week:
        _calculateVMFromDate(firstDayOfCurrentWeek());
      case TimePeriod.month:
        _calculateVMFromDate(firstDayOfCurrentMonth());
      case TimePeriod.all:
        _calculateVMFromDate(DateTime(0));
    }
  }

  void _calculateVMFromDate(DateTime date) {
    int i = 0;
    double total = 0.0;
    while (i < _expenses.length &&
        _expenses[i].createdAt.compareTo(date) >= 0) {
      total += _expenses[i++].amount;
    }
    _vm = TotalAmountCardVM(total, i);
    _vmController.add(_vm);
  }

  void _updateStreams() {
    _totalAmountController.add(_calculateTotalOfCurrentWeek());
    _expensesController.add(
      _expenses.length <= 4 ? List.from(_expenses) : _expenses.sublist(0, 4),
    );
    _updateVM();
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

  Future<void> setTimePeriod(TimePeriod newValue) async {
    _statusController.add(StateStatus.loading);
    await _prefs.setInt(_key, newValue.index);
    _currentTimePeriod = newValue;
    _timePeriodController.add(newValue);
    _updateVM();
    //await Future.delayed(Duration(milliseconds: 2000));
    _statusController.add(StateStatus.done);
  }
}

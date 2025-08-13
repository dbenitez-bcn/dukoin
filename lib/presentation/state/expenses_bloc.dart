import 'dart:async';

import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/domain/state_status.dart';
import 'package:dukoin/domain/time_period.dart';
import 'package:dukoin/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesBloc {
  static final String _key = 'time_period';
  final ExpenseRepository _repo;
  final SharedPreferences _prefs;
  final _totalAmountController = StreamController<double>();
  final _expensesController = StreamController<List<Expense>>();
  final _timePeriodController = StreamController<TimePeriod>();
  final _statusController = StreamController<StateStatus>();
  final TimePeriod initialTimePeriod = TimePeriod.week;

  List<Expense> _expenses = [];
  TimePeriod _currentTimePeriod = TimePeriod.week;
  double _amount = 0.0;
  int _totalTransaction = 0;

  ExpensesBloc(this._repo, this._prefs);

  int get total => _expenses.length;

  TimePeriod get currentTimePeriod => _currentTimePeriod;

  Stream<double> get totalAmountStream => _totalAmountController.stream;

  Stream<List<Expense>> get expensesStream => _expensesController.stream;

  Stream<TimePeriod> get timePeriodStream => _timePeriodController.stream;

  Stream<StateStatus> get statusStream => _statusController.stream;

  double get amount => _amount;

  int get totalTransactions => _totalTransaction;

  Future<void> load() async {
    _expenses = await _repo.getAll();
    _currentTimePeriod = TimePeriod.values[_prefs.getInt(_key) ?? 1];
    _timePeriodController.add(_currentTimePeriod);
    _updateData();
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

  void _updateData() {
    switch (_currentTimePeriod) {
      case TimePeriod.day:
        _calculateTotalFromDate(currentDayDate());
      case TimePeriod.week:
        _calculateTotalFromDate(firstDayOfCurrentWeek());
      case TimePeriod.month:
        _calculateTotalFromDate(firstDayOfCurrentMonth());
      case TimePeriod.all:
        _calculateTotalFromDate(DateTime(0));
    }
  }

  void _calculateTotalFromDate(DateTime date) {
    int i = 0;
    double total = 0.0;
    while (i < _expenses.length &&
        _expenses[i].createdAt.compareTo(date) >= 0) {
      total += _expenses[i++].amount;
    }
    _totalTransaction = i;
    _amount = total;
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
    _updateData();
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
    _updateData();
    //await Future.delayed(Duration(milliseconds: 500));
    _statusController.add(StateStatus.done);
  }
}

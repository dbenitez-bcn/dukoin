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
  final StateStatus initialStatus = StateStatus.loading;
  final TimePeriod initialTimePeriod = TimePeriod.week;

  List<Expense> _expenses = [];
  TimePeriod _currentTimePeriod = TimePeriod.week;

  ExpensesBloc(this._repo, this._prefs);

  int get total => _expenses.length;

  TimePeriod get currentTimePeriod => _currentTimePeriod;

  Stream<double> get totalAmountStream => _totalAmountController.stream;

  Stream<StateStatus> get statusStream => _statusController.stream;

  Stream<List<Expense>> get expensesStream => _expensesController.stream;

  Stream<TimePeriod> get timePeriodStream => _timePeriodController.stream;

  Future<void> load() async {
    _expenses = await _repo.getAll();
    _currentTimePeriod = TimePeriod.values[_prefs.getInt(_key) ?? 1];
    _timePeriodController.add(_currentTimePeriod);
    _updateStreams();
    _statusController.add(StateStatus.done);
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

  Future<void> setTimePeriod(TimePeriod newValue) async {
    _statusController.add(StateStatus.loading);
    await _prefs.setInt(_key, newValue.index);
    _currentTimePeriod = newValue;
    _timePeriodController.add(newValue);
    //await Future.delayed(Duration(milliseconds: 500));
    _statusController.add(StateStatus.done);
  }
}

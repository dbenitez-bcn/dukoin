import 'dart:async';

import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/domain/time_period.dart';
import 'package:dukoin/domain/total_amount_vm.dart';
import 'package:dukoin/domain/transaction.dart';
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

  final _lastExpensesController = StreamController<List<Transaction>>();
  final _timePeriodController = StreamController<TimePeriod>();
  final TimePeriod initialTimePeriod = TimePeriod.week;

  List<Transaction> _expenses = [];
  TimePeriod _currentTimePeriod = TimePeriod.week;

  ExpensesBloc(this._repo, this._prefs);

  TimePeriod get currentTimePeriod => _currentTimePeriod;

  List<Transaction> get lastExpenses => _expenses;

  Stream<List<Transaction>> get lastExpensesStream =>
      _lastExpensesController.stream;

  Stream<TimePeriod> get timePeriodStream => _timePeriodController.stream;

  Future<void> load() async {
    _expenses = await _repo.getLast();
    _currentTimePeriod = TimePeriod.values[_prefs.getInt(_key) ?? 1];
    _timePeriodController.add(_currentTimePeriod);
    await _updateVM();
    _updateStreams();
    await Future.delayed(Duration(seconds: 1, milliseconds: 500));
  }

  Future<void> _updateVM() async {
    switch (_currentTimePeriod) {
      case TimePeriod.day:
        _vm = await _repo.getTotalAmount(
          start: DateUtils.currentDayDate(),
          end: DateUtils.currentDayDate(),
        );
      case TimePeriod.week:
        var start = DateUtils.firstDayOfCurrentWeek();
        var end = start.add(Duration(days: 7));
        _vm = await _repo.getTotalAmount(start: start, end: end);
      case TimePeriod.month:
        var start = DateUtils.firstDayOfCurrentMonth();
        final end = DateTime(start.year, start.month + 1, 0);
        _vm = await _repo.getTotalAmount(start: start, end: end);
      case TimePeriod.all:
        _vm = await _repo.getTotalAmount(
          start: DateTime(0),
          end: DateTime.now(),
        );
    }
    _vmController.add(_vm);
  }

  Future<void> _updateStreams() async {
    _expenses = await _repo.getLast();
    _lastExpensesController.add(_expenses);
    await _updateVM();
  }

  Future<void> addExpense(Transaction expense) async {
    await _repo.insert(expense);
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

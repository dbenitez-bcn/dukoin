import 'dart:async';

import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/domain/month_overview_vm.dart';
import 'package:dukoin/domain/state_status.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class StatsProvider extends InheritedWidget {
  final StatsBloc bloc;

  StatsProvider({super.key, required super.child})
    : bloc = StatsBloc(GetIt.I<ExpenseRepository>());

  static StatsBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StatsProvider>()!.bloc;
  }

  @override
  bool updateShouldNotify(StatsProvider oldWidget) => false;
}

class StatsBloc {
  final ExpenseRepository _expenseRepository;
  final StateStatus initialStatus = StateStatus.done;
  DateTime _selectedMonth;
  List<ExpenseCategory> _selectedCategories;
  List<DateTime> _availableMonths;
  final StreamController<StateStatus> _statusController =
      StreamController<StateStatus>.broadcast();
  MonthOverviewVM _monthOverviewVM = MonthOverviewVM(0, 0, 0, 0);

  StatsBloc(this._expenseRepository)
    : _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month, 1),
      _selectedCategories = [],
      _availableMonths = [
        DateTime(DateTime.now().year, DateTime.now().month, 1),
      ];

  DateTime get selectedMonth => _selectedMonth;

  List<ExpenseCategory> get selectedCategories =>
      List.unmodifiable(_selectedCategories);

  List<DateTime> get availableMonths => List.unmodifiable(_availableMonths);

  Stream<StateStatus> get statusStream => _statusController.stream;

  MonthOverviewVM get monthOverview => _monthOverviewVM;

  Future<void> onMonthSelected(DateTime newDate) async {
    _statusController.add(StateStatus.loading);
    _selectedMonth = newDate;
    await loadMonthOverview();
    _statusController.add(StateStatus.done);
  }

  Future<void> onCategoriesUpdated(List<ExpenseCategory> newCategories) async {
    _statusController.add(StateStatus.loading);
    _selectedCategories = newCategories;
    await loadMonthOverview();
    _statusController.add(StateStatus.done);
  }

  Future<void> loadAvailableMonths() async {
    final oldestDate = await _expenseRepository.getOldestExpenseDate();
    if (oldestDate == null) {
      _availableMonths = [
        DateTime(DateTime.now().year, DateTime.now().month, 1),
      ];
      return;
    }

    final months = <DateTime>[];
    var current = DateTime(DateTime.now().year, DateTime.now().month, 1);
    final oldest = DateTime(oldestDate.year, oldestDate.month, 1);

    while (current.isAfter(oldest) || current.isAtSameMomentAs(oldest)) {
      months.add(current);
      current = DateTime(current.year, current.month - 1, 1);
    }

    _availableMonths = months;
  }

  Future<void> loadMonthOverview() async {
    await Future.delayed(Duration(milliseconds: 500));
    final now = DateTime.now();
    DateTime end = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);
    if (end.isAfter(now)) {
      end = now;
    }
    if (end.isBefore(_selectedMonth)) {
      end = _selectedMonth;
    }

    final int daysBetween = end.difference(_selectedMonth).inDays + 1;
    final int weeksBetween = (daysBetween / 7).floor().clamp(1, daysBetween);

    final overview = await _expenseRepository.getTotalAmount(
      start: _selectedMonth,
      end: end,
      categories: _selectedCategories
    );
    _monthOverviewVM = MonthOverviewVM(
      overview.amount,
      overview.amount / daysBetween,
      overview.amount / weeksBetween,
      overview.totalTransactions,
    );
  }

  void dispose() {
    _statusController.close();
  }
}

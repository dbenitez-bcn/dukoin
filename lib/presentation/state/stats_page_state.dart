import 'dart:async';

import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';
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
  StreamController<StateStatus> _statusController = StreamController<StateStatus>.broadcast();

  StatsBloc(this._expenseRepository)
    : _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month, 1),
      _selectedCategories = [],
      _availableMonths = [
        DateTime(DateTime.now().year, DateTime.now().month, 1),
      ];

  DateTime get selectedMonth => _selectedMonth;
  List<ExpenseCategory> get selectedCategories => List.unmodifiable(_selectedCategories);
  List<DateTime> get availableMonths => List.unmodifiable(_availableMonths);
  Stream<StateStatus> get statusStream => _statusController.stream;

  void onMonthSelected(DateTime newDate) async {
    _statusController.add(StateStatus.loading);
    _selectedMonth = newDate;
    _statusController.add(StateStatus.done);
  }

  void onCategoriesUpdated(List<ExpenseCategory> newCategories) {
    _statusController.add(StateStatus.loading);
    _selectedCategories = newCategories;
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

  void dispose() {
    _statusController.close();
  }
}

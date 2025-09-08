import 'dart:async';

import 'package:dukoin/domain/category_breakdown_vm.dart';
import 'package:dukoin/domain/category_frequency_vm.dart';
import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/domain/month_evolution_vm.dart';
import 'package:dukoin/domain/month_overview_vm.dart';
import 'package:dukoin/domain/state_status.dart';
import 'package:dukoin/domain/time_interval.dart';
import 'package:dukoin/domain/total_per_day_dto.dart';
import 'package:fl_chart/fl_chart.dart';
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
  List<Expense> _topFiveExpenses = [];
  MonthEvolutionVM _monthEvolutionVM = MonthEvolutionVM([]);
  CategoryBreakdownVM _categoryBreakdown = CategoryBreakdownVM([]);
  CategoryFrequencyVM _categoryFrequency = CategoryFrequencyVM([]);

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

  List<Expense> get topFiveExpenses => List.unmodifiable(_topFiveExpenses);

  MonthEvolutionVM get monthEvolution => _monthEvolutionVM;

  CategoryBreakdownVM get categoryBreakdown => _categoryBreakdown;

  CategoryFrequencyVM get categoryFrequency => _categoryFrequency;

  Future<void> onMonthSelected(DateTime newDate) async {
    _selectedMonth = newDate;
    await _updateState();
  }

  Future<void> onCategoriesUpdated(List<ExpenseCategory> newCategories) async {
    _selectedCategories = newCategories;
    await _updateState();
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
    final selectedInterval = _getMonthInterval(_selectedMonth);

    final int daysBetween = selectedInterval.duration.inDays + 1;
    final int weeksBetween = (daysBetween / 7).floor().clamp(1, daysBetween);

    final overview = await _expenseRepository.getTotalAmount(
      start: selectedInterval.start,
      end: selectedInterval.end,
      categories: _selectedCategories,
    );
    _monthOverviewVM = MonthOverviewVM(
      overview.amount,
      overview.amount / daysBetween,
      overview.amount / weeksBetween,
      overview.totalTransactions,
    );
  }

  Future<void> loadHighestExpenses() async {
    _topFiveExpenses = await _expenseRepository.getTopHighestExpenses(
      start: _selectedMonth,
      end: DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0),
      categories: _selectedCategories,
    );
  }

  Future<void> loadMonthEvolution() async {
    final selectedInterval = _getMonthInterval(_selectedMonth);
    List<TotalPerDayDTO> dataSelected = await _expenseRepository.getTotalPerDay(
      start: selectedInterval.start,
      end: selectedInterval.end,
      categories: _selectedCategories,
    );

    var previousStart = DateTime(
      _selectedMonth.year,
      _selectedMonth.month - 1,
      1,
    );
    final previousInterval = _getMonthInterval(previousStart);
    List<TotalPerDayDTO> dataPrevious = await _expenseRepository.getTotalPerDay(
      start: previousInterval.start,
      end: previousInterval.end,
      categories: _selectedCategories,
    );

    MonthEvolutionData selectedData = MonthEvolutionData(
      _selectedMonth,
      _accumulateSpots(dataSelected),
    );

    MonthEvolutionData previousData = MonthEvolutionData(
      previousStart,
      _accumulateSpots(dataPrevious),
    );

    _monthEvolutionVM = MonthEvolutionVM([selectedData, previousData]);
  }

  Future<void> loadCategoryBreakdown() async {
    final selectedInterval = _getMonthInterval(_selectedMonth);
    var distribution = await _expenseRepository.getCategoriesDistribution(
      start: selectedInterval.start,
      end: selectedInterval.end,
      categories: _selectedCategories,
    );
    var total = 0.0;
    for (var e in distribution) {
      total += e.value;
    }

    final data = distribution
        .map((e) => CategoryBreakdownData(e.category, e.value, e.value / total))
        .toList();

    _categoryBreakdown = CategoryBreakdownVM(data);
  }

  Future<void> loadCategoryFrequency() async {
    final selectedInterval = _getMonthInterval(_selectedMonth);

    var frequencies = await _expenseRepository.getCategoryFrequencies(
      start: selectedInterval.start,
      end: selectedInterval.end,
      categories: _selectedCategories,
    );

    _categoryFrequency = CategoryFrequencyVM(frequencies);
  }

  List<FlSpot> _accumulateSpots(List<TotalPerDayDTO> data) {
    double sum = 0;
    return data.map((e) {
      sum += e.total;
      return FlSpot(e.date.day.toDouble(), sum);
    }).toList();
  }

  TimeInterval _getMonthInterval(DateTime date) {
    final start = DateTime(date.year, date.month, 1);
    final end = DateTime(date.year, date.month + 1, 0);
    return TimeInterval(start, end);
  }

  Future<void> _updateState() async {
    _statusController.add(StateStatus.loading);
    await loadMonthOverview();
    await loadMonthEvolution();
    await loadHighestExpenses();
    await loadCategoryBreakdown();
    await loadCategoryFrequency();
    _statusController.add(StateStatus.done);
  }

  void dispose() {
    _statusController.close();
  }
}

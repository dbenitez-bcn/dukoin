import 'package:dukoin/domain/expense.dart';
import 'package:flutter/material.dart';

class StatsProvider extends InheritedWidget {
  final StatsBloc bloc;

  StatsProvider({super.key, required super.child}) : bloc = StatsBloc();

  static StatsBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StatsProvider>()!.bloc;
  }

  @override
  bool updateShouldNotify(StatsProvider oldWidget) => false;
}

class StatsBloc {
  DateTime _selectedDate;
  List<ExpenseCategory> _selectedCategories;

  StatsBloc()
    : _selectedDate = DateTime(DateTime.now().year, DateTime.now().month, 1),
      _selectedCategories = [];

  DateTime get selectedDate => _selectedDate;
  List<ExpenseCategory> get selectedCategories => _selectedCategories;

  void onDateSelected(DateTime newDate) {
    _selectedDate = newDate;
  }

  void onCategoriesUpdated(List<ExpenseCategory> newCategories) {
    _selectedCategories = newCategories;
  }
}

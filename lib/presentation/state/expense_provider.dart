import 'package:dukoin/infrastructure/database_provider.dart';
import 'package:dukoin/infrastructure/sqflite_expense_repository.dart';
import 'package:dukoin/presentation/state/expenses_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesProvider extends InheritedWidget {
  final ExpensesBloc bloc;

  ExpensesProvider({super.key, required super.child, required SharedPreferences prefs})
    : bloc = ExpensesBloc(SqfliteExpenseRepository(DatabaseProvider()), prefs);

  static ExpensesBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExpensesProvider>()!.bloc;
  }

  @override
  bool updateShouldNotify(ExpensesProvider oldWidget) => false;
}

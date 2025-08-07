import 'package:dukoin/infrastructure/database_provider.dart';
import 'package:dukoin/infrastructure/sqflite_expense_repository.dart';
import 'package:dukoin/presentation/state/expenses_bloc.dart';
import 'package:flutter/widgets.dart';

class ExpensesProvider extends InheritedWidget {
  final ExpensesBloc bloc;

  ExpensesProvider({super.key, required super.child})
    : bloc = ExpensesBloc(SqfliteExpenseRepository(DatabaseProvider()));

  static ExpensesBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExpensesProvider>()!.bloc;
  }

  @override
  bool updateShouldNotify(ExpensesProvider oldWidget) => false;
}

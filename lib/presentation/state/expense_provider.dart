import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/presentation/state/expenses_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesProvider extends InheritedWidget {
  final ExpensesBloc bloc;

  ExpensesProvider({super.key, required super.child})
    : bloc = ExpensesBloc(
        GetIt.I<ExpenseRepository>(),
        GetIt.I<SharedPreferences>(),
      );

  static ExpensesBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExpensesProvider>()!.bloc;
  }

  @override
  bool updateShouldNotify(ExpensesProvider oldWidget) => false;
}

import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/domain/time_period.dart';
import 'package:dukoin/presentation/state/expenses_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'expenses_bloc_test.mocks.dart';

@GenerateMocks([ExpenseRepository])
void main() {
  group("Expenses Bloc", () {
    group("time period", () {
      var mockExpenseRepository = MockExpenseRepository();
      when(mockExpenseRepository.getAll()).thenAnswer((_) async => []);
      test("It should load week as default time priod", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        ExpensesBloc sut = ExpensesBloc(mockExpenseRepository, prefs);

        expect(sut.currentTimePeriod, TimePeriod.week);
      });

      test("Given a new time period it should update time period", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        ExpensesBloc sut = ExpensesBloc(mockExpenseRepository, prefs);

        await sut.setTimePeriod(TimePeriod.month);

        expect(sut.currentTimePeriod, TimePeriod.month);
        expect(prefs.getInt('time_period'), TimePeriod.month.index);
      });

      test("It should load time period when a value is given", () async {
        SharedPreferences.setMockInitialValues({
          'time_period': TimePeriod.day.index,
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        ExpensesBloc sut = ExpensesBloc(mockExpenseRepository, prefs);

        await sut.load();

        expect(sut.currentTimePeriod, TimePeriod.day);
      });
    });
  });
}

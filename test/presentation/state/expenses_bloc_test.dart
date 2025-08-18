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
      when(mockExpenseRepository.getLast()).thenAnswer((_) async => []);
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

      test("It should have a default VM value", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        ExpensesBloc sut = ExpensesBloc(mockExpenseRepository, prefs);

        await sut.load();

        expect(sut.vm.amount, 0.0);
        expect(sut.vm.totalTransactions, 0);
      });
      /*
      var vmTestCases = [
        {'period': TimePeriod.day, 'expected': TotalAmountCardVM(10.0, 1)},
        {'period': TimePeriod.week, 'expected': TotalAmountCardVM(32.0, 2)},
        {'period': TimePeriod.month, 'expected': TotalAmountCardVM(65.0, 3)},
        {'period': TimePeriod.all, 'expected': TotalAmountCardVM(121.0, 4)},
      ];
      for (var tc in vmTestCases) {
        test(
          "Given a ${tc['period']} period should yield ${tc['expected']}",
          () async {
            var mockRepo = MockExpenseRepository();
            when(mockRepo.getLast()).thenAnswer((_) async => [
              Expense(amount: 10, category: ExpenseCategory.food, description: "A", createdAt: DateTime.now()),
              Expense(amount: 22, category: ExpenseCategory.food, description: "B", createdAt: firstDayOfCurrentWeek()),
              Expense(amount: 33, category: ExpenseCategory.food, description: "C", createdAt: firstDayOfCurrentMonth()),
              Expense(amount: 56, category: ExpenseCategory.food, description: "D", createdAt: DateTime(2000)),
            ]);
            SharedPreferences.setMockInitialValues({});
            SharedPreferences prefs = await SharedPreferences.getInstance();
            ExpensesBloc sut = ExpensesBloc(mockRepo, prefs);

            await sut.load();
            await sut.setTimePeriod(tc['period'] as TimePeriod);

            expect(sut.vm.amount, (tc['expected'] as TotalAmountCardVM).amount);
            expect(sut.vm.totalTransactions, (tc['expected'] as TotalAmountCardVM).totalTransactions);
          },
        );
      }
       */
    });
  });
}

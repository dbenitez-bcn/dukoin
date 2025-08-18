import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/domain/time_period.dart';
import 'package:dukoin/domain/total_amount_vm.dart';
import 'package:dukoin/presentation/state/expenses_bloc.dart';
import 'package:dukoin/utils/utils.dart';
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
      when(
        mockExpenseRepository.getTotalAmount(date: anyNamed("date")),
      ).thenAnswer((_) async => TotalAmountVM(0, 0));
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

      group("setTimePeriod", () {
        var expectedVM = TotalAmountVM(0, 0);
        test(
          "When time period is DAY, should call repository with curren day",
          () async {
            var mockRepo = MockExpenseRepository();
            SharedPreferences.setMockInitialValues({});
            SharedPreferences prefs = await SharedPreferences.getInstance();
            when(
              mockRepo.getTotalAmount(date: anyNamed("date")),
            ).thenAnswer((_) async => expectedVM);
            ExpensesBloc sut = ExpensesBloc(mockRepo, prefs);

            await sut.setTimePeriod(TimePeriod.day);

            verify(mockRepo.getTotalAmount(date: currentDayDate())).called(1);
            expectLater(sut.vmStream, emits(expectedVM));
          },
        );
        test(
          "When time period is WEEK, should call repository with curren day",
          () async {
            var mockRepo = MockExpenseRepository();
            SharedPreferences.setMockInitialValues({});
            SharedPreferences prefs = await SharedPreferences.getInstance();
            when(
              mockRepo.getTotalAmount(date: anyNamed("date")),
            ).thenAnswer((_) async => expectedVM);
            ExpensesBloc sut = ExpensesBloc(mockRepo, prefs);

            await sut.setTimePeriod(TimePeriod.week);

            verify(
              mockRepo.getTotalAmount(date: firstDayOfCurrentWeek()),
            ).called(1);
            expectLater(sut.vmStream, emits(expectedVM));
          },
        );
        test(
          "When time period is MONTH, should call repository with curren day",
          () async {
            var mockRepo = MockExpenseRepository();
            SharedPreferences.setMockInitialValues({});
            SharedPreferences prefs = await SharedPreferences.getInstance();
            when(
              mockRepo.getTotalAmount(date: anyNamed("date")),
            ).thenAnswer((_) async => expectedVM);
            ExpensesBloc sut = ExpensesBloc(mockRepo, prefs);

            await sut.setTimePeriod(TimePeriod.month);

            verify(
              mockRepo.getTotalAmount(date: firstDayOfCurrentMonth()),
            ).called(1);
            expectLater(sut.vmStream, emits(expectedVM));
          },
        );
        test(
          "When time period is ALL, should call repository with fist day",
          () async {
            var mockRepo = MockExpenseRepository();
            SharedPreferences.setMockInitialValues({});
            SharedPreferences prefs = await SharedPreferences.getInstance();
            when(
              mockRepo.getTotalAmount(date: anyNamed("date")),
            ).thenAnswer((_) async => expectedVM);
            ExpensesBloc sut = ExpensesBloc(mockRepo, prefs);

            await sut.setTimePeriod(TimePeriod.all);

            verify(mockRepo.getTotalAmount(date: DateTime(0))).called(1);
            expectLater(sut.vmStream, emits(expectedVM));
          },
        );
      });
    });
  });
}

import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/domain/time_period.dart';
import 'package:dukoin/domain/total_amount_vm.dart';
import 'package:dukoin/domain/transaction_repository.dart';
import 'package:dukoin/presentation/state/expenses_bloc.dart';
import 'package:dukoin/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'expenses_bloc_test.mocks.dart';

// TODO: Add tests for addExpense
@GenerateMocks([ExpenseRepository, TransactionRepository])
void main() {
  group("Expenses Bloc", () {
    group("time period", () {
      var mockExpenseRepository = MockExpenseRepository();
      var mockTransactionRepository = MockTransactionRepository();
      when(mockExpenseRepository.getLast()).thenAnswer((_) async => []);
      when(
        mockExpenseRepository.getTotalAmount(
          start: anyNamed("start"),
          end: anyNamed("end"),
        ),
      ).thenAnswer((_) async => TotalAmountVM(0, 0));
      test("It should load week as default time priod", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        ExpensesBloc sut = ExpensesBloc(
          mockExpenseRepository,
          mockTransactionRepository,
          prefs,
        );

        expect(sut.currentTimePeriod, TimePeriod.week);
      });

      test("Given a new time period it should update time period", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        ExpensesBloc sut = ExpensesBloc(
          mockExpenseRepository,
          mockTransactionRepository,
          prefs,
        );

        await sut.setTimePeriod(TimePeriod.month);

        expect(sut.currentTimePeriod, TimePeriod.month);
        expect(prefs.getInt('time_period'), TimePeriod.month.index);
      });

      test("It should load time period when a value is given", () async {
        SharedPreferences.setMockInitialValues({
          'time_period': TimePeriod.day.index,
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        ExpensesBloc sut = ExpensesBloc(
          mockExpenseRepository,
          mockTransactionRepository,
          prefs,
        );

        await sut.load();

        expect(sut.currentTimePeriod, TimePeriod.day);
      });

      test("It should have a default VM value", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        ExpensesBloc sut = ExpensesBloc(
          mockExpenseRepository,
          mockTransactionRepository,
          prefs,
        );

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
              mockRepo.getTotalAmount(
                start: anyNamed("start"),
                end: anyNamed("end"),
              ),
            ).thenAnswer((_) async => expectedVM);
            ExpensesBloc sut = ExpensesBloc(
              mockRepo,
              mockTransactionRepository,
              prefs,
            );

            await sut.setTimePeriod(TimePeriod.day);

            verify(
              mockRepo.getTotalAmount(
                start: DateUtils.currentDayDate(),
                end: DateUtils.currentDayDate(),
              ),
            ).called(1);
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
              mockRepo.getTotalAmount(
                start: anyNamed("start"),
                end: anyNamed("end"),
              ),
            ).thenAnswer((_) async => expectedVM);
            ExpensesBloc sut = ExpensesBloc(
              mockRepo,
              mockTransactionRepository,
              prefs,
            );

            await sut.setTimePeriod(TimePeriod.week);

            var start = DateUtils.firstDayOfCurrentWeek();
            var end = start.add(Duration(days: 7));
            verify(mockRepo.getTotalAmount(start: start, end: end)).called(1);
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
              mockRepo.getTotalAmount(
                start: anyNamed("start"),
                end: anyNamed("end"),
              ),
            ).thenAnswer((_) async => expectedVM);
            ExpensesBloc sut = ExpensesBloc(
              mockRepo,
              mockTransactionRepository,
              prefs,
            );

            await sut.setTimePeriod(TimePeriod.month);

            var start = DateUtils.firstDayOfCurrentMonth();
            var end = DateTime(start.year, start.month + 1, 0);
            verify(mockRepo.getTotalAmount(start: start, end: end)).called(1);
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
              mockRepo.getTotalAmount(
                start: anyNamed("start"),
                end: anyNamed("end"),
              ),
            ).thenAnswer((_) async => expectedVM);
            ExpensesBloc sut = ExpensesBloc(
              mockRepo,
              mockTransactionRepository,
              prefs,
            );

            await sut.setTimePeriod(TimePeriod.all);

            verify(
              mockRepo.getTotalAmount(start: DateTime(0), end: anyNamed("end")),
            ).called(1);
            expectLater(sut.vmStream, emits(expectedVM));
          },
        );
      });
    });
  });
}
